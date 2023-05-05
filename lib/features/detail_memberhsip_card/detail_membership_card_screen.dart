import 'package:flutter/material.dart';
import 'package:meca_wallet/constants/colors.dart';

import '../../model/membership_card.dart';
import '../../widgets/membership_store_card.dart';
import 'widgets/accumulated_point.dart';
import 'widgets/transaction_history.dart';
import 'widgets/utility_panel.dart';

class DetailMembershipCardScreen extends StatelessWidget {
  const DetailMembershipCardScreen({super.key});
  static String routeName = '/detailMemcardScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFillColorPrimary,
      appBar: AppBar(
        backgroundColor: kFillColorPrimary,
        iconTheme: const IconThemeData(color: kPrimaryPurple),
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              size: 30,
            )),
        elevation: 0,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              text: "Thẻ thành viên",
              style: TextStyle(
                  color: kTextColorAccent, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: '\nNhà gỗ quán',
                  style: TextStyle(
                      color: kTextColorAccent,
                      height: 1.6,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,

        ///here
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AccumulatedPoint(),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MembershipStoreCard(
                card: MembershipCardModel(
                    'Cheese Coffee',
                    'assets/images/jollibee_logo.png',
                    'Phong Trinh',
                    21,
                    3,
                    cardColors[0]),
              ),
            ),
            const SizedBox(height: 15),
            const UtilityPanel(),
            const TransactionHistory()
          ],
        ),
      ),
    );
  }
}
