import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BackButtonLS extends StatelessWidget {
  const BackButtonLS({super.key});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      constraints: const BoxConstraints.tightFor(
        width: 32,
        height: 40,
      ),
      child: const Icon(
        Icons.arrow_back_ios,
        color: kPrimaryPurple,
      ),
    );
  }
}
