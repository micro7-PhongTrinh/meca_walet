import 'package:flutter/material.dart';
import 'package:meca_service/data/store.dart';

import '../store_screen.dart';

class StoreRepresentInfor extends StatelessWidget {
  const StoreRepresentInfor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Store store = StoreValue.of(context).store;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 2,
                  wordSpacing: 3),
            ),
            const Text(
              "Meca's Partner",
              style: TextStyle(
                  color: Color.fromARGB(255, 146, 144, 144),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.2),
            ),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(top: 5),
            height: 56,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  store.logoUrl,
                  fit: BoxFit.fill,
                )))
      ],
    );
  }
}
