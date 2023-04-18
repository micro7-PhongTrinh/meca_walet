import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meca_wallet/features/home/featured_product.dart';

void main() {
  group('Categry tab test', () {
    final List<String> categories = [
      'Quần áo',
      'Coffee',
      'Nhà hàng',
      'Mua sắm',
      'Ăn vặt',
    ];
    testWidgets('Verify category tab UI', (widgetTester) async {
      await widgetTester.pumpAndSettle(const Duration(seconds: 5));
      await widgetTester.pumpWidget(
          MaterialApp(home: FeaturedProduct(categories: categories)),
          const Duration(seconds: 3));
    });
    testWidgets('Change avtive button and scroll to view when click',
        (widgetTester) async {});
    testWidgets('Change category list when click to button type',
        (widgetTester) async {});
  });
}
