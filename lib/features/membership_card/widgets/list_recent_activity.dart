import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/membership_card/bloc/get_current_activity_cubit.dart';
import 'package:meca_wallet/model/card_activity_model.dart';

import '../../../widgets/tab_title.dart';

class ListRecentActivity extends StatelessWidget {
  const ListRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    GetCurrentActivityCubit cubit =
        BlocProvider.of<GetCurrentActivityCubit>(context);
    cubit.getCurrentActivities();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TabTitle(
          title: 'Hoạt động gần đây',
        ),
        const SizedBox(height: 20),
        Expanded(child: ListActivityTag())
      ],
    );
  }
}

class ListActivityTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<GetCurrentActivityCubit, GetCurrentActivityState>(
      bloc: BlocProvider.of<GetCurrentActivityCubit>(context),
      builder: (context, state) {
        if (state is GetCurrentActivitySuccess) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(state.cards.length,
                  (index) => RecentActivity(activity: state.cards[index])),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
                6,
                (index) => Container(
                      color: kGreyShade2,
                      height: 54,
                      margin: EdgeInsets.only(top: 12),
                    )),
          ),
        );
      },
    );
  }
}

class RecentActivity extends StatelessWidget {
  final CardActivityModel activity;
  const RecentActivity({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 56,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundImage: NetworkImage(activity.urlImage)),
              )),
          SizedBox(width: 15),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Text(activity.content)
                ],
              )),
          SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: Text('+${activity.upPoint}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)))
        ],
      ),
    );
  }
}
