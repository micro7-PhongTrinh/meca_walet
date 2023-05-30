import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:meca_service/src/meca_service_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/event.dart';
import '../data/featured_member_card.dart';
import '../data/member_card.dart';
import '../data/product.dart';
import '../data/store.dart';
import '../data/user.dart';
import '../exception/meca_service_exception.dart';
import 'authentication_exception.dart';
import 'provider_authentication.dart';

class MecaService {
  final MecaServiceRequest _mecaServiceRequest;
  final ProviderAuthentication _providerAuthentication;

  final StreamController<User> _userController;
  final StreamController<MemberCard> _memcardController;

  Stream<User?> get user => _userController.stream;

  Stream<MemberCard> get memcard => _memcardController.stream;

  MecaService(
      {MecaServiceRequest? mecaServiceRequest,
      ProviderAuthentication? providerAuthentication})
      : _mecaServiceRequest = mecaServiceRequest ?? MecaServiceRequest(),
        _providerAuthentication =
            providerAuthentication ?? ProviderAuthentication(),
        _userController = StreamController.broadcast(),
        _memcardController = StreamController.broadcast();

  Future<User> signinGoogle() async {
    try {
      String googleToken = await _providerAuthentication.signinGoogle();
      _userController
          .add(await _mecaServiceRequest.authWithGoogle(googleToken));
      User? user = await _mecaServiceRequest.authWithGoogle(googleToken);
      _userController.add(user);
    } catch (e) {
      rethrow;
    }
    return await getCurrentUser();
  }

  Future<User> checkSignedinUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var jwt = localStorage.getString('jwt');
    if (jwt != null) {
      await _resigninUser();
    }
    return await getCurrentUser();
  }

  Future<void> _resigninUser() async {
    try {
      String googleToken = await _providerAuthentication.signinSilentlyGoogle();
      User checkUser = await _mecaServiceRequest.authWithGoogle(googleToken);
      _userController.add(checkUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signout() async {
    await _providerAuthentication.signoutGoogle();
  }

  Future<User> getCurrentUser() async {
    final User? checkUser = await user.last;
    if (checkUser == null) {
      throw AuthenticationException('User not found');
    } else {
      return checkUser;
    }
  }

  //handle flow for any authenticated get request
  Future<dynamic> _baseGetRequest(String url) async {
    dynamic data = {};
    try {
      String token = await _getAuthenticatedToken();
      final Response response = await get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var e = response.body;
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else if (response.statusCode == 401) {
        await _resigninUser();
        await _baseGetRequest(url);
      }
    } catch (e) {
      throw Exception();
    }
    return data;
  }

  Future<dynamic> _basePostRequest(String url) async {
    dynamic data = {};
    try {
      String token = await _getAuthenticatedToken();
      final Response response = await post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var e = response.body;
      if (response.statusCode == 200) {
        data = json.decode(response.body);
      } else if (response.statusCode == 401) {
        await _resigninUser();
        await _baseGetRequest(url);
      }
    } catch (e) {
      throw Exception();
    }
    return data;
  }

  Future<List<Store>> getFeaturedStores() async {
    List<dynamic> data =
        await _baseGetRequest(_mecaServiceRequest.getFeaturedStoresUrl());

    return List<Store>.from(data.map((e) => Store.fromJson(e)));
  }

  Future<List<Product>> getFeaturedProducts() async {
    List<dynamic> data =
        await _baseGetRequest(_mecaServiceRequest.getFeaturedProductsUrl());

    return List<Product>.from(data.map((e) => Product.fromJson(e)));
  }

  Future<List<Product>> getStoreProducts(String storeId) async {
    List<dynamic> data =
        await _baseGetRequest(_mecaServiceRequest.getStoreProductsUrl(storeId));

    return List<Product>.from(data.map((e) => Product.fromJson(e)));
  }

  Future<Store> getDetailStore(String id) async {
    var response =
        await _baseGetRequest(_mecaServiceRequest.getDetailStoreUrl(id));

    return Store.fromJson(response['data']);
  }

  Future<FeaturedMemberCard> getFeaturedMemberCards() async {
    var data =
        await _baseGetRequest(_mecaServiceRequest.getFeaturedMemberCardsUrl());

    return FeaturedMemberCard.fromJson(data);
  }

  Future<List<MemberCard>> getAllMembershipCards() async {
    var response =
        await _baseGetRequest(_mecaServiceRequest.getAllMemberCardsUrl());
    List<dynamic> data = response['data'];
    return List<MemberCard>.from(data.map((e) => MemberCard.fromJson(e)));
  }

  Future<MemberCard?> getDetailMemberCard(String storeId) async {
    dynamic data = await _baseGetRequest(
        _mecaServiceRequest.getDetailMemberCardUrl(storeId));
    try {
      return MemberCard.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<MemberCard> createDetailMemberCard(String storeId) async {
    var data = await _basePostRequest(
        _mecaServiceRequest.getDetailMemberCardUrl(storeId));
    try {
      MemberCard card = MemberCard.fromJson(data);
      _memcardController.add(card);
      return card;
    } catch (e) {
      throw OtherException;
    }
  }

  Future<List<Event>> getHappeningStoreEvent(String storeId) async {
    List<dynamic> data =
        await _baseGetRequest(_mecaServiceRequest.getStoreEventdUrl(storeId));

    return List<Event>.from(data.map((e) => Event.fromJson(e)));
  }

  // Future<List<MemberCard>> getAllMemberCards(String userId) async {
  //   var data = await _baseGetRequest(_mecaServiceRequest.getFeaturedMemberCardsUrl(userId));

  //   return data.map(a => MemberCard.fromJson(a));
  // }

  // Future<MemberCard> getDetailMemberCard(String userId, String cardId) async {
  //   var data = await _baseGetRequest(_mecaServiceRequest.getDetailMemberCardUrl(userId, cardId));

  //   return MemberCard.fromJson(data);
  // }

  // Future<List<Product>> getFeaturedProducts() async {
  //   var data = await _baseGetRequest(_mecaServiceRequest.getFeaturedProductsUrl());

  //   return Product.fromJson(data);
  // }

  Future<String> _getAuthenticatedToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? jwt = localStorage.getString('jwt');

    if (jwt == null || jwt.isEmpty) throw UnauthenticatedRequest;

    return jwt;
  }
}
