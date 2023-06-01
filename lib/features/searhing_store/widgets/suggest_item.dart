import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_service/data/store.dart';
import 'package:meca_wallet/constants/colors.dart';

class SuggestItem extends StatelessWidget {
  const SuggestItem({super.key, required this.store});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Row(
          children: [
            Container(
                width: 60,
                decoration: ShapeDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(store.logoUrl)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ))),
            const SizedBox(width: 15),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryPurple,
                          overflow: TextOverflow.ellipsis)),
                  Text(store.location,
                      style:
                          const TextStyle(fontSize: 16, color: kTextColorThird),
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            )
          ],
        ));
  }
}
