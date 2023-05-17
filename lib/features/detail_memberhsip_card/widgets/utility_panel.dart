import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/detail_memberhsip_card/widgets/user_infor_dialog.dart';
import 'package:meca_wallet/features/store/store_screen.dart';

import 'cancel_membership_dialog.dart';

class UtilityPanel extends StatelessWidget {
  const UtilityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: AdvancedButton(
                icon: Icons.person,
                content: 'Thông tin',
                onTap: () => _showInformationDialog(context),
              ),
            ),
            Expanded(
                flex: 1,
                child: AdvancedButton(
                    icon: Icons.storefront,
                    content: 'Cửa hàng',
                    onTap: () => Navigator.of(context)
                        .pushNamed(StoreScreen.routeName))),
            Expanded(
                flex: 1,
                child: AdvancedButton(
                    icon: Icons.close,
                    content: 'Hủy thẻ',
                    onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => const CancelMembershipDialog(),
                        )))
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

  void _showInformationDialog(context) {
    showDialog(
        context: context, builder: ((context) => const UserInforDialog()));
  }
}

class AdvancedButton extends StatelessWidget {
  const AdvancedButton(
      {super.key,
      required this.icon,
      required this.content,
      required this.onTap});

  final IconData icon;
  final String content;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
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
      ),
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
