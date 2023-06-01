import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

enum ItemType { store, event, product }

class FeaturedItem extends StatelessWidget {
  const FeaturedItem(
      {super.key,
      required this.itemtype,
      required this.imgUrl,
      this.storeName,
      required this.content});
  final ItemType itemtype;
  final String imgUrl;
  final String? storeName;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 160,
              decoration: ShapeDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(imgUrl)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ))),
          const SizedBox(height: 10),
          Expanded(
              child: ItemTitle(
                  itemType: itemtype, content: content, storeName: storeName))
        ],
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  const ItemTitle(
      {super.key,
      required this.itemType,
      this.storeName,
      required this.content});
  final ItemType itemType;
  final String? storeName;
  final String content;

  @override
  Widget build(BuildContext context) {
    if (itemType == ItemType.store) {
      return StoreTitle(storeName: storeName!, content: content);
    }
    return ProductTitle(content: content);
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18, color: kTextColorAccent));
  }
}

class StoreTitle extends StatelessWidget {
  const StoreTitle({
    super.key,
    required this.storeName,
    required this.content,
  });

  final String storeName;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          storeName,
          style: const TextStyle(
              fontSize: 18, color: kTextColor, fontWeight: FontWeight.bold),
        ),
        Text(content,
            style: const TextStyle(fontSize: 18, color: kTextColorAccent))
      ],
    );
  }
}
