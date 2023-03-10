import 'package:flutter/material.dart';
import '../constants/colors.dart';

class OptionButton extends StatelessWidget {
  final String desc;
  final String method;
  final Function onPressHandler;

  const OptionButton(
      {super.key, required this.desc, required this.method, required this.onPressHandler});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressHandler,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(text: desc),
            TextSpan(
              text: method,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kPrimaryPurple,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
