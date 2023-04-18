import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      width: 112,
      child: Stack(
        children: [
          Container(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: kGreyShade5,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(
                8,
              ),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: kPrimaryPurple,
              ),
              child: Image.asset('assets/images/camera.png'),
            ),
          )
        ],
      ),
    );
  }
}
