import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_service/data/store.dart';
import '../constants/colors.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, required this.store});
  final Store store;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: 280,
      height: 170,
      margin: const EdgeInsets.only(
        right: 16,
      ),
      decoration: ShapeDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(store.imgUrl[0])),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            kGradientColor,
            kGradientColor.withOpacity(0),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.fade,
              store.location,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
