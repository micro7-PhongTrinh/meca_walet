import 'package:flutter/material.dart';

import 'widgets/app_represent.dart';
import 'widgets/featured_membership_card.dart';
import 'widgets/featured_product.dart';
import 'widgets/recommended_store.dart';

class MWHome extends StatelessWidget {
  const MWHome({
    Key? key,
  }) : super(key: key);

  static String routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: const _IDHomeView());
  }
}

class _IDHomeView extends StatelessWidget {
  const _IDHomeView();

  // import category from outside make testable
  final List<String> categories = const [
    'Quần áo',
    'Coffee',
    'Nhà hàng',
    'Mua sắm',
    'Ăn vặt',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 64),
        child: Column(children: [
          const AppRepresent(),
          const SizedBox(height: 64),
          const FeaturedMembershipCard(),
          const SizedBox(height: 64),
          FeaturedProduct(categories: categories),
          const SizedBox(height: 64),
          const RecommendedStore(),
        ]));
  }
}
