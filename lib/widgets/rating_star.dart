import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ),
         SizedBox(width: 5)
      ],
    );
  }
}
