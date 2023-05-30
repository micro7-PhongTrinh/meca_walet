import 'dart:convert';

import 'package:meca_service/src/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/user.dart';
import '../exception/meca_service_exception.dart';

class MecaServiceRequest {
  Future<User> authWithGoogle(String accessToken) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.authGooglePath}?${ApiConstant.accessTokenParam}$accessToken');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        _storeAthenticationToken(_getReponseField(response.body, 'jwt'));
        User user = praseUsersFromJson(_getReponseField(response.body, 'user'));
        return user;
      }
    } catch (e) {
      rethrow;
    }
    throw OtherException;
  }

  String getFeaturedStoresUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.featuredStoresPath}';
  }

  String getFeaturedProductsUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.featuredProductsPath}';
  }

  String getStoreProductsUrl(String storeId) {
    return '${ApiConstant.baseUrl}${ApiConstant.storeProductsPath}?${ApiConstant.storeIdParam}$storeId';
  }

  String getFeaturedMemberCardsUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.featuredMemberCardsPath}';
  }

  String getAllMemberCardsUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.memberCardsPath}?populate=*';
  }

  String getDetailMemberCardUrl(String storeId) {
    return '${ApiConstant.baseUrl}${ApiConstant.detailMemberCardsPath}?${ApiConstant.storeIdParam}$storeId';
  }

  String getDetailStoreUrl(String id) {
    return '${ApiConstant.baseUrl}${ApiConstant.storePath}/$id';
  }

  String getStoreEventdUrl(String storeId) {
    return '${ApiConstant.baseUrl}${ApiConstant.storeEventPath}?${ApiConstant.storeIdParam}$storeId';
  }

  Future<User> getUser() async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.authGooglePath}?${ApiConstant.authMe}');
      print('url: ' + url.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        _storeAthenticationToken(_getReponseField(response.body, 'jwt'));
        User user = praseUsersFromJson(_getReponseField(response.body, 'user'));
        return user;
      }
    } catch (e) {
      rethrow;
    }
    throw OtherException;
  }

  //Make a auth request with jwt store before
  Future<String> _getAuthenticatedToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? jwt = localStorage.getString('jwt');

    if (jwt == null) throw UnauthenticatedRequest;

    return jwt;
  }

  //Store jwt when login success or refresh expired jwt
  Future<void> _storeAthenticationToken(String jwt) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool t = await localStorage.setString('jwt', jwt);
    if (t) {
      print('store jwt success');
    }
  }

  static User praseUsersFromJson(Map<String, dynamic> json) {
    try {
      return User.fromJson(json);
    } catch (e) {
      throw DataMappingException;
    }
  }

  dynamic _getReponseField(String json, String field) {
    try {
      Map<String, dynamic> parsed = jsonDecode(json);
      return parsed[field];
    } catch (e) {
      throw DataMappingException;
    }
  }
}
