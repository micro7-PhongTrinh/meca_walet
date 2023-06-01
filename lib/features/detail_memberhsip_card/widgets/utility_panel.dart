import 'package:flutter/material.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/detail_memberhsip_card/widgets/user_infor_dialog.dart';
import 'package:meca_wallet/features/store/store_screen.dart';

import 'cancel_membership_dialog.dart';

class UtilityPanel extends StatelessWidget {
  const UtilityPanel({super.key, required this.detailCard});

  final DetailMemberCard detailCard;

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
                onTap: () => showDialog(
                    context: context,
                    builder: ((context) => UserCardInforDialog(
                          detailCard: detailCard,
                        ))),
              ),
            ),
            Expanded(
                flex: 1,
                child: AdvancedButton(
                    icon: Icons.storefront,
                    content: 'Cửa hàng',
                    onTap: () => Navigator.of(context).pushNamed(
                        StoreScreen.routeName,
                        arguments: detailCard.card.store.id))),
            Expanded(
                flex: 1,
                child: AdvancedButton(
                    icon: Icons.close, content: 'Hủy thẻ', onTap: () {}))
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
              text: "Thẻ thành viên được cung cấp bởi Meca Wallet",
              style: TextStyle(color: kPrimaryPurple),
              children: <TextSpan>[
                TextSpan(
                  text: '\nCác thông tin của bạn sẽ được quản lý và bảo vệ!',
                  style: TextStyle(color: kPrimaryPurple, height: 1.6),
                ),
              ]),
        ),
      ),
    );
  }
}
