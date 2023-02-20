import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:onepos_service/src/models/category.dart';

void main() {
  test('Map category model as expect from Json', () {
    final file =
        File('test/test_resources/temp_category.json').readAsStringSync();
    final category =
        CategoryModel.fromJson(jsonDecode(file) as Map<String, dynamic>);
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
}
