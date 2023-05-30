import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/store/bloc/get_memcard_cubit.dart';

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
    return BlocProvider<GetMemcardCubit>(
      create: (_) => GetMemcardCubit(mecaService: RepositoryProvider.of<MecaService>(context)),
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
        title: 
                BlocBuilder<GetMemcardCubit, GetMemcardState>(
                  bloc: BlocProvider.of<GetMemcardCubit>(context),
                  builder: (context, state) {
                    if(state is GetMemcardSuccess) {
                      return
          RichText(
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
          );
                    }
                    return RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
                text: "Thẻ thành viên",
                style: TextStyle(
                    color: kTextColorAccent, fontWeight: FontWeight.bold)));
                    }
                    ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AccumulatedPoint(),
            const SizedBox(height: 10),
            BlocBuilder<GetMemcardCubit, GetMemcardState>(
                  bloc: BlocProvider.of<GetMemcardCubit>(context),
                  builder: (context, state) {
                    if(state is GetMemcardSuccess) {
                      return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MembershipStoreCard(
                  card: state.card,
                ),
              );}
              return Container();
              }
            ),
            const SizedBox(height: 30),
            const UtilityPanel(),
            const SizedBox(height: 30),
            const TransactionHistory()
          ],
        ),
      ),
    );
  }
}
