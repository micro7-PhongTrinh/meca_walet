import 'package:flutter/material.dart';

class MembershipStoreMoreCard extends StatelessWidget {
  final int otherCardsnumber;
  const MembershipStoreMoreCard({super.key, required this.otherCardsnumber});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: const Color.fromARGB(255, 26, 25, 25).withOpacity(0.7)),
        child: Center(
            child: Text(
          '+${otherCardsnumber.toString()}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold),
        )));
  }
}
