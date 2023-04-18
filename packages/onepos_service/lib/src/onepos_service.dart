import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:onepos_service/src/request_exception.dart';

import 'api_parameters/create_category_param.dart';
import 'models/category.dart';
import 'api_constant.dart';

class OneposService {
  final Client client;

  OneposService(this.client);

  Future<CategoryModel> createCategory(CreateCategoryParam param) async {
    try {
      //create category
      //var url = Uri.parse('${ApiConstant.baseUrl}/categories');
      final response =
          await sendPostRequest('categories', _parsePostCategoryBody(param));
      return CategoryModel.fromJson(jsonDecode(response.body)['data']);
    } on InvalidInputException {
      throw InvalidInputException('');
    } catch (e) {
      throw Exception();
    }
  }

  Future<Response> sendPostRequest(
      String endpoint, Map<String, String> body) async {
    try {
      var url = Uri.parse('${ApiConstant.baseUrl}/$endpoint');
      final response = await client.post(url, body: body);
      return response;
    } catch (e) {
      throw InvalidInputException('Invalid input');
    }
  }

  Map<String, String> _parsePostCategoryBody(CreateCategoryParam param) {
    if (param.name.isEmpty) {
      throw InvalidInputException('Invalid input');
    }
    return {
      'categoryName': param.name,
      'parentCategoryId': param.parentId ?? '',
      'description': param.description ?? ''
    };
  }
}
