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

      print(url.toString());
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

  String getSuggestStoresUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.suggestStoresPath}';
  }

  String getFilteredStoresUrl(String searchString) {
    return '${ApiConstant.baseUrl}${ApiConstant.filteredStoresPath}?${ApiConstant.searchParam}$searchString';
  }

  String getFeaturedProductsUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.featuredProductsPath}';
  }

  String getStoreProductsUrl(String storeId) {
    return '${ApiConstant.baseUrl}${ApiConstant.storeProductsPath}?${ApiConstant.storeIdParam}$storeId';
  }

  String getFeaturedDetailMemberCardsUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.featuredMemberCardsPath}';
  }

  String getAllDetailMemberCardsUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.allmemberCardsPath}';
  }

  String getDetailMemberCardByStoreUrl(String storeId) {
    return '${ApiConstant.baseUrl}${ApiConstant.detailMemberCardsByStorePath}?${ApiConstant.storeIdParam}$storeId';
  }

  String getDetailMemberCardByCardUrl(String cardId) {
    return '${ApiConstant.baseUrl}${ApiConstant.detailMemberCardsByMemberCardPath}?${ApiConstant.cardIdParam}$cardId';
  }

  String getDetailStoreUrl(String id) {
    return '${ApiConstant.baseUrl}${ApiConstant.storePath}/$id';
  }

  String getStoreEventdUrl(String storeId) {
    return '${ApiConstant.baseUrl}${ApiConstant.storeEventPath}?${ApiConstant.storeIdParam}$storeId';
  }

  String getFeaturedEventdUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.featuredEventPath}';
  }

  String getLatelyActivityUrl() {
    return '${ApiConstant.baseUrl}${ApiConstant.latelyActivitiesPath}';
  }

  String getActivityByMemberCardUrl(String cardId) {
    return '${ApiConstant.baseUrl}${ApiConstant.activitiesByMemberCardPath}?${ApiConstant.cardIdParam}$cardId';
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
      print('store jwt success' + jwt);
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
