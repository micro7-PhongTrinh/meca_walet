import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_service/meca_service.dart';

import '../../../bloc/common_cubit/get_current_activity_cubit.dart';
import '../../../constants/colors.dart';
import '../../../widgets/skeleton/recent_activity_skeleton.dart';
import '../../../widgets/tab_title.dart';
import '../../overview_membership_card/widgets/list_recent_activity.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key, required this.detailCard});

  final DetailMemberCard detailCard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCurrentActivityCubit(
          mecaService: RepositoryProvider.of<MecaService>(context)),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              const TabTitle(
                title: 'Hoạt động gần đây',
                padding: 0,
              ),
              const SizedBox(height: 10),
              _ListTransaction(detailCard.card.id.toString())
            ],
          )),
    );
  }
}

class _ListTransaction extends StatelessWidget {
  const _ListTransaction(this.cardId);

  final String cardId;

  @override
  Widget build(BuildContext context) {
    GetCurrentActivityCubit cubit =
        BlocProvider.of<GetCurrentActivityCubit>(context);
    cubit.getActivitiesByMemberCard(cardId);

    return BlocBuilder<GetCurrentActivityCubit, GetCurrentActivityState>(
        bloc: BlocProvider.of<GetCurrentActivityCubit>(context),
        builder: (context, state) {
          if (state is GetCurrentActivitySuccess) {
            return Column(
              children: List.generate(state.activities.length,
                  (index) => RecentActivity(activity: state.activities[index])),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children:
                  List.generate(6, (index) => const RecentActivitySkeleton()),
            ),
          );
        });
  }
}
