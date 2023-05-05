import 'package:flutter/material.dart';
import 'package:meca_wallet/features/store/store_screen.dart';
import 'package:meca_wallet/model/store_card.dart';

import '../../../widgets/store_card.dart';
import '../../../widgets/tab_title.dart';

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
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(StoreScreen.routeName),
                      child: StoreCard(
                        card: StoreCardModel(
                            '1988s Coffee',
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5KzFVA7g5mrYy9mvu6MFYX60hE5z3qh2vdA&usqp=CAU',
                            '128 Phan Xích Long, Phường 7, Phú Nhuận'),
                      )),
                  InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(StoreScreen.routeName),
                      child: StoreCard(
                        card: StoreCardModel(
                            'Cheese Coffee',
                            'https://znews-photo.zingcdn.me/w660/Uploaded/ngtrzz/2021_10_01/205902abbfda76842fcb.jpg',
                            '47G Hoa Lan, Phường 2, Phú Nhuận'),
                      )),
                ],
              ),
            )),
      ],
    );
  }
}
