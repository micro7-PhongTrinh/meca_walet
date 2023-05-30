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
    return const Scaffold(body: _IDHomeView());
  }
}

class _IDHomeView extends StatelessWidget {
  const _IDHomeView();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 64),
        child: Column(children: [
          AppRepresent(),
          SizedBox(height: 48),
          FeaturedMembershipCard(),
          SizedBox(height: 48),
          FeaturedProduct(),
          SizedBox(height: 64),
          RecommendedStore(),
        ]));
  }
}
