import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final Function? seeAll;
  final double padding;

  const TabTitle(
      {super.key,
      required this.title,
      this.seeAll,
      this.actionText = 'Tất cả',
      this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          if (seeAll != null)
            TextButton(
              onPressed: () => seeAll,
              child: Text(
                actionText,
              ),
            ),
        ],
      ),
    );
  }
}
