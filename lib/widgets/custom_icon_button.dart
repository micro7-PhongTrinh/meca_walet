import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final double size;

  const CustomIconButton(this.icon, this.onPress, {super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: RawMaterialButton(
        fillColor: kGreyShade5,
        elevation: 0,
        constraints: BoxConstraints.tightFor(
          width: size,
          height: size,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        onPressed:() => onPress,
        child: Icon(
          icon,
          color: kGreyShade1,
          size: size / 2,
        ),
      ),
    );
  }
}
