import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class CardLogo extends StatelessWidget {
  final String urlImage;
  const CardLogo(this.urlImage, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 72,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Image(image: CachedNetworkImageProvider(urlImage), height: 48),
          const Text(
            'Membership card',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ));
}
