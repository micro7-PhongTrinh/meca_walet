import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

class UtilityPanel extends StatelessWidget {
  const UtilityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              flex: 1,
              child: AdvancedButton(icon: Icons.person, content: 'Thông tin'),
            ),
            Expanded(
                flex: 1,
                child: AdvancedButton(
                    icon: Icons.storefront, content: 'Cửa hàng')),
            Expanded(
                flex: 1,
                child: AdvancedButton(icon: Icons.close, content: 'Hủy thẻ'))
          ],
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: CardNotification(),
        )
      ],
    );
  }
}

class AdvancedButton extends StatelessWidget {
  const AdvancedButton({super.key, required this.icon, required this.content});

  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Column(children: [
        Icon(
          icon,
          color: kTextColorAccent,
          weight: 0.1,
          size: 30,
        ),
        const SizedBox(height: 5),
        Text(content,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kTextColorAccent))
      ]),
    );
  }
}

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: const BoxDecoration(
          color: kAccentPurple,
          borderRadius: BorderRadius.all(
              Radius.circular(10.0) //                 <--- border radius here
              )),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              text: "Thẻ thành viên thành viên thành viên thành viên",
              style: TextStyle(color: kPrimaryPurple),
              children: <TextSpan>[
                TextSpan(
                  text: '\nNhà gỗ quán thành viên thành viên!',
                  style: TextStyle(color: kPrimaryPurple, height: 1.6),
                ),
              ]),
        ),
      ),
    );
  }
}
