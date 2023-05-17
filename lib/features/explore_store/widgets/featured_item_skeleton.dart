import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

class FeaturedItemSkeleton extends StatelessWidget {
  const FeaturedItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 160,
              decoration: ShapeDecoration(
                  color: kFillColorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ))),
          const SizedBox(height: 10)
        ],
      ),
    );
    ;
  }
}
