import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:onepos_service/onepos_service.dart';
import 'package:onepos_service/src/api_parameters/create_category_param.dart';
import 'package:onepos_service/src/request_exception.dart';

void main() {
  //test request
  //turong hop gui duoc
  Future<http.Response> mockSuccessfulRequest(http.Request request) async {
    return http.Response(
        File('test/test_resources/temp_category.json').readAsStringSync(), 200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
  }

  Future<http.Response> mockFailRequest(http.Request request) async {
    return http.Response('fewfwef', 404);
  }

  Future<http.Response> mockInvalidInputRequest(http.Request request) async {
    return http.Response('Input invalid', 400);
  }

  test('test request send successfuly', () async {
    final oneposService = OneposService(MockClient(mockSuccessfulRequest));

    var category = await oneposService
        .createCategory(CreateCategoryParam(name: 'no no no'));

    expect(category.id, '1');
    expect(category.name, '1');
    expect(
      category.description,
      'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    );
    expect(
      category.parentId,
      'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto',
    );
  });

  //truong hop khong gui dc
  test('test request not successfuly send', () async {
    Future<http.Response> mockRequest(http.Request request) async {
      return http.Response('fewfwef', 404);
    }

    final oneposService = OneposService(MockClient(mockFailRequest));

    expect(
        () => oneposService.createCategory(CreateCategoryParam(name: 'nonono')),
        throwsA(isA<Exception>()));
  });

  //neu thieu cac field yeu cau cua api thi tra ve loi
  test('test request with field name is wrong', () async {
    final oneposService = OneposService(MockClient(mockSuccessfulRequest));

    expect(() => oneposService.createCategory(CreateCategoryParam(name: '')),
        throwsA(isA<Exception>()));
  });
  //khi gui dung tra ve 200
  test('return status code 200 when successfully', () async {
    final oneposService = OneposService(MockClient(mockSuccessfulRequest));
    final response = await oneposService
        .sendPostRequest('categories', {'categoryName': 'nonoooo'});
    expect(response.statusCode, 200);
  });
  //gui sai tra ve error vaf loi
  //handle error ntn

  //as user, I want to know exactly kind of error that I turn to
  test(
      'Response status code 405 when Invalid Input, then throw InvalidInputException',
      () async {
    final oneposService = OneposService(MockClient(mockInvalidInputRequest));

    expect(() => oneposService.createCategory(CreateCategoryParam(name: '')),
        throwsA(isA<InvalidInputException>()));
  });

  test(
      'Response status fail other reason throw a RequestFailException and error message',
      () async {
    final oneposService = OneposService(MockClient(mockSuccessfulRequest));

    expect(() => oneposService.createCategory(CreateCategoryParam(name: '')),
        throwsA(isA<RequestFailException>()));
  });
}
