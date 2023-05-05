import 'package:flutter/widgets.dart';

import '../../../constants/colors.dart';

class StoreBoxContent extends StatelessWidget {
  const StoreBoxContent({
    super.key,
    required this.widget, required this.title,
  });
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: const BoxDecoration(
          color: kFillColorThird,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15),
          widget
        ],
      ),
    );
  }
}
