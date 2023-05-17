import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class StoreAvatar extends StatelessWidget {
  const StoreAvatar({super.key, required this.logoUrl});

  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        height: 56,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: logoUrl,
              fit: BoxFit.fill,
              placeholder: (context, _) =>
                  Container(width: 56, color: kGreyShade2),
            )));
  }
}
