import 'package:flutter/material.dart';
import '../constants/colors.dart';

class StoreCard extends StatelessWidget {
  final bool isHorizontalScrolling;
  final Function onTap;

  const StoreCard(
      {super.key, required this.onTap, this.isHorizontalScrolling = true});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        alignment: Alignment.bottomLeft,
        width: 280,
        height: 170,
        margin: EdgeInsets.only(
          right: isHorizontalScrolling ? 16 : 0,
          bottom: !isHorizontalScrolling ? 32 : 0,
        ),
        decoration: ShapeDecoration(
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/1988s-coffee.png')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              kGradientColor,
              kGradientColor.withOpacity(0),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '1988s Coffee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                maxLines: 1,
                overflow: TextOverflow.fade,
                '128 Phan Xích Long, Phường 7, Phú Nhuận',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
