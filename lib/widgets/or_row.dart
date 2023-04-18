import 'package:flutter/material.dart';
import '../constants/colors.dart';

class OrRow extends StatelessWidget {
  const OrRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: const [
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            'OR',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: kTextColorAccent),
          ),
        ),
        Expanded(
          child: Column(
            children: const [
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ],
    );
  }
}
