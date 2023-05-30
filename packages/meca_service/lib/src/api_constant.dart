import 'dart:convert';

class ApiConstant {
  static const String baseUrl = 'http://10.0.2.2:1337';
  static const String authGooglePath = '/api/auth/google/callback';
  static const String authMe = '/api/users/me';
  static const String featuredStoresPath = '/api/featured-store';
  static const String featuredProductsPath = '/api/featured-product';
  static const String storeProductsPath = '/api/store-product';
  static const String featuredMemberCardsPath = '/api/my-featured-member-card';
  static const String memberCardsPath = '/api/member-cards';
  static const String detailMemberCardsPath = '/api/my-detail-member-card';
  static const String storePath = '/api/stores';
  static const String storeEventPath = '/api/store-event';
  static const String accessTokenParam = 'access_token=';
  static const String storeIdParam = 'storeId=';
  static Map<String, dynamic> praseJsonFromBody(String body) {
    Map<String, dynamic> parsed = jsonDecode(body);
    return parsed;
  }
}
