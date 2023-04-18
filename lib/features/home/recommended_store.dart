import 'package:flutter/material.dart';

import '../../widgets/store_card.dart';
import '../../widgets/tab_title.dart';

class RecommendedStore extends StatelessWidget {
  const RecommendedStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(title: 'Phù hợp với bạn', seeAll: () {}),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StoreCard(onTap: () {}),
              StoreCard(onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
