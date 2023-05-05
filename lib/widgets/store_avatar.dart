import 'package:flutter/material.dart';

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
            child: Image.network(
              logoUrl,
              fit: BoxFit.fill,
            )));
  }
}
