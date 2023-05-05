import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/model/card_activity.dart';
import 'package:meca_wallet/widgets/error/recent_activity_error.dart';

import '../../../widgets/skeleton/recent_activity_skeleton.dart';
import '../../../widgets/tab_title.dart';
import '../bloc/get_current_activity_cubit.dart';

class ListRecentActivity extends StatelessWidget {
  const ListRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    GetCurrentActivityCubit cubit =
        BlocProvider.of<GetCurrentActivityCubit>(context);
    cubit.getCurrentActivities();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TabTitle(
          title: 'Hoạt động gần đây',
        ),
        SizedBox(height: 32),
        Expanded(child: ListActivityTag())
      ],
    );
  }
}

class ListActivityTag extends StatelessWidget {
  const ListActivityTag({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentActivityCubit, GetCurrentActivityState>(
      bloc: BlocProvider.of<GetCurrentActivityCubit>(context),
      builder: (context, state) {
        if (state is GetCurrentActivitySuccess) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(state.activities.length,
                  (index) => RecentActivity(activity: state.activities[index])),
            ),
          );
        }
        if (state is GetCurrentActivityFail) {
          return const RecentActivityError();
        }
        return SingleChildScrollView(
          child: Column(
            children:
                List.generate(6, (index) => const RecentActivitySkeleton()),
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
      margin: const EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(5),
              child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(45),
                      child: Image.network(activity.urlImage))),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  Text(activity.content)
                ],
              )),
          const SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: Text('+${activity.upPoint}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)))
        ],
      ),
    );
  }
}
