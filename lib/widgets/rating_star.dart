import 'package:flutter/material.dart';

import '../model/featured_product.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
    required this.ratePoint,
  });

  final double ratePoint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          ratePoint.toString(),
          style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
        )
      ],
    );
  }
}
