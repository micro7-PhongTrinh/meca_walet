import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

class AccumulatedPoint extends StatelessWidget {
  const AccumulatedPoint({super.key, required this.point});

  final int point;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${point.toString()} điểm',
          style: const TextStyle(
              color: kTextColor, fontSize: 30, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
