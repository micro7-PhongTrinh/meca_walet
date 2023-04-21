import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String text;

  const CustomTextIconButton(
      {super.key,
      required this.icon,
      required this.onPress,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
