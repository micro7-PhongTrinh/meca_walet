import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomNavBar extends StatefulWidget {
  final int curTabIndex;
  final Function(int) onTap;
  const CustomNavBar(this.onTap, this.curTabIndex, {super.key});
  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (tabIndex) {
        widget.onTap(tabIndex);
      },
      selectedItemColor: kPrimaryPurple,
      unselectedItemColor: kGreyShade2,
      currentIndex: widget.curTabIndex,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 0
              ? Image.asset(
                  'assets/images/home_nav.png',
                )
              : Image.asset(
                  'assets/images/home_nav_notfill.png',
                ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 1
              ? Image.asset(
                  'assets/images/star_nav_fill.png',
                )
              : Image.asset(
                  'assets/images/star_nav.png',
                ),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 2
              ? Image.asset(
                  'assets/images/cart_nav_fill.png',
                )
              : Image.asset(
                  'assets/images/cart_nav.png',
                ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 3
              ? Image.asset(
                  'assets/images/profile_nav_fill.png',
                )
              : Image.asset(
                  'assets/images/user_nav.png',
                ),
          label: 'Profile',
        ),
      ],
    );
  }
}
