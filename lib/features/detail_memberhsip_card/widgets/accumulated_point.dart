import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

class AccumulatedPoint extends StatelessWidget {
  const AccumulatedPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          '32 điểm',
          style: TextStyle(
              color: kTextColor, fontSize: 30, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
