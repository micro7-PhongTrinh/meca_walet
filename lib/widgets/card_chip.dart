import 'package:flutter/material.dart';

class CardChip extends StatelessWidget {
  const CardChip({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          Image(
            image: AssetImage('assets/images/creditcardchipsilver.png'),
            width: 50.0,
          ),
        ],
      );
}
