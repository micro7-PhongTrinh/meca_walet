import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PriceBreakdown extends StatelessWidget {
  const PriceBreakdown({
    required Key key,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: kTextColorAccent,
              ),
        ),
        const Spacer(),
        Text(
          price,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: kTextColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
