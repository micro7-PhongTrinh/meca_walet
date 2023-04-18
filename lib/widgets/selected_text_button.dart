import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SelectedTextButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onTap;
  const SelectedTextButton(this.text, this.isSelected, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
          color: isSelected ? kPrimaryPurple : kTextColorForth,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: kPrimaryPurple)),
      child: Material(
        color: Colors.transparent,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onTap();
            Scrollable.ensureVisible(context,
                duration: const Duration(milliseconds: 400));
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 18, right: 18),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: isSelected ? kTextColorForth : kPrimaryPurple,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
