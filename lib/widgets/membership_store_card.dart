import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meca_wallet/model/membership_card.dart';

import '../constants/colors.dart';
import 'card_chip.dart';
import 'card_logo.dart';

class MembershipStoreCard extends StatelessWidget {
  MembershipStoreCard({super.key, required this.card});

  final MembershipCardModel card;

  static const Widget dotPadding = SizedBox(width: 24);
  static const Widget dot = Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text(
        "•",
        textScaleFactor: 2,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ));


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.white),
          color: card.cardColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CardChip(),
                  CardLogo(card.imageUrl),
                ]),
            const SizedBox(height: 40),
            Wrap(
                children: List<Widget>.filled(
              9,
              dot,
              growable: true,
            )
                  ..insert(
                      // now get the spaces
                      3,
                      dotPadding)
                  ..insert(7, dotPadding)
                  ..add(dotPadding)),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                card.ownerName,
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Open\nfrom",
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 0.8,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '${card.openDate.toString()}/${card.openMonth.toString()}',
                    style: const TextStyle(color: Colors.white),
                    textScaleFactor: 1.4,
                  )
                ],
              )
            ]),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
