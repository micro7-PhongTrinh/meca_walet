import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FeaturedProductSkeleton extends StatelessWidget {
  const FeaturedProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  height: 160,
                  width: 112,
                  margin: const EdgeInsets.only(right: 8),
                  color: kFillColorPrimary,
                );
  }
}