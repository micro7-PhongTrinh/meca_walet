import 'dart:convert';

class ApiConstant {
  static String baseUrl = 'https://onepos.com.vn/';
  static String categoryEndpoint = 'api/categories';

  static Map<String, dynamic> praseJsonFromBody(String body) {
    Map<String, dynamic> parsed = jsonDecode(body);
    return parsed;
  }
}
