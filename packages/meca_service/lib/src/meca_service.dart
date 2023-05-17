import 'dart:convert';

import 'package:meca_service/src/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/user.dart';
import '../exception/meca_service_exception.dart';

class MecaService {
  late String _authToken;

  Future<User> authWithGoogle(String accessToken) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.authGooglePath}?${ApiConstant.accessTokenParam}$accessToken');
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

  Future<User> getUser() async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.authGooglePath}?${ApiConstant.accessTokenParam}');
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
  Future<void> _setAuthenticatedToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? jwt = localStorage.getString('jwt');

    if (jwt == null) throw UnauthenticatedRequest;

    _authToken = jwt;

    print('set auth token success: ' + _authToken);
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

  static dynamic _getReponseField(String json, String field) {
    try {
      Map<String, dynamic> parsed = jsonDecode(json);
      return parsed[field];
    } catch (e) {
      throw DataMappingException;
    }
  }
}
