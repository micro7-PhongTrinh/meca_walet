import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/explore_store/explore_store_screen.dart';

class AppRepresent extends StatelessWidget {
  const AppRepresent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        color: kPrimaryPurple,
        child: Column(children: [
          Image.asset(
            'assets/images/meca_logo.png',
          ),
          const StoreSearchNavigator()
        ]));
  }
}

class StoreSearchNavigator extends StatelessWidget {
  const StoreSearchNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.of(context).pushNamed(ExploreStoreScreen.routeName),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 56,
            decoration: const BoxDecoration(
                color: kGreyShade6,
                borderRadius: BorderRadius.all(Radius.circular(45))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Khám phá các cửa hàng trên Meca',
                  style: TextStyle(color: kTextColorAccent),
                ),
                Icon(Icons.search, color: kTextColorAccent)
              ],
            )));
  }
}
