import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/widgets/membership_store_card.dart';
import 'package:meca_wallet/widgets/skeleton/membership_card_skeleton.dart';

import '../bloc/get_memcard_cubit.dart';
import 'store_box_content.dart';

class MembershipIntegrateCard extends StatelessWidget {
  const MembershipIntegrateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: const StoreBoxContent(
          title: 'Thẻ thành viên', widget: MembershipStoreBody()),
    );
  }
}

class MembershipStoreBody extends StatelessWidget {
  const MembershipStoreBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetMemcardCubit>(context).getStoreMemcard('123');
    return BlocBuilder<GetMemcardCubit, GetMemcardState>(
        bloc: BlocProvider.of<GetMemcardCubit>(context),
        builder: (context, state) {
          if (state is GetMemcardSuccess) {
            return MembershipStoreCard(card: state.card);
          }
          return const MembershipCardSkeleton();
        });
  }
}

class MembershipInregrateButton extends StatelessWidget {
  const MembershipInregrateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: kPrimaryPurple, padding: const EdgeInsets.all(16)),
        onPressed: () {},
        child: const Text('Liên kết thẻ thành viên',
            style: TextStyle(color: kTextColorForth)));
  }
}
