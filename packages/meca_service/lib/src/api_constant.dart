import 'dart:convert';

class ApiConstant {
  static const String baseUrl = 'http://10.0.2.2:1337';
  static const String authGooglePath = '/api/auth/google/callback';
  static const String accessTokenParam = 'access_token=';
  static Map<String, dynamic> praseJsonFromBody(String body) {
    Map<String, dynamic> parsed = jsonDecode(body);
    return parsed;
  }
}
