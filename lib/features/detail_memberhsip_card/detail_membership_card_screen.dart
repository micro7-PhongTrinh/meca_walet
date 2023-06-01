import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/constants/colors.dart';

import '../../widgets/membership_store_card.dart';
import 'bloc/get_detail_memcard_cubit.dart';
import 'widgets/accumulated_point.dart';
import 'widgets/transaction_history.dart';
import 'widgets/utility_panel.dart';

class DetailMembershipCardScreen extends StatelessWidget {
  const DetailMembershipCardScreen({super.key});
  static String routeName = '/detailMemcardScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetDetailMemcardCubit>(
      create: (_) => GetDetailMemcardCubit(
          mecaService: RepositoryProvider.of<MecaService>(context)),
      child: const DetailMemcardScreenBody(),
    );
  }
}

class DetailMemcardScreenBody extends StatelessWidget {
  const DetailMemcardScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DetailMemberCard detailCard =
        ModalRoute.of(context)!.settings.arguments as DetailMemberCard;
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
          text: TextSpan(
              text: "Thẻ thành viên",
              style: const TextStyle(
                  color: kTextColorAccent, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: '\n${detailCard.card.name}',
                  style: const TextStyle(
                      color: kTextColorAccent,
                      height: 1.6,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccumulatedPoint(point: detailCard.point),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MembershipStoreCard(
                detailCard: detailCard,
              ),
            ),
            const SizedBox(height: 30),
            UtilityPanel(detailCard: detailCard),
            const SizedBox(height: 30),
            TransactionHistory(detailCard: detailCard)
          ],
        ),
      ),
    );
  }
}
