import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/common_cubit/get_event_cubit.dart';
import '../../../widgets/tab_title.dart';
import '../../store/store_screen.dart';
import 'featured_item.dart';
import 'featured_item_skeleton.dart';

class FeaturedEvents extends StatelessWidget {
  const FeaturedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetEventCubit>(context).getFeaturedEvents();
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(title: 'Sự kiện đang diễn ra', padding: 0),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: FeaturedEventItems())
      ],
    );
  }
}

class FeaturedEventItems extends StatelessWidget {
  const FeaturedEventItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetEventCubit, GetEventState>(
        bloc: BlocProvider.of<GetEventCubit>(context),
        builder: (context, state) {
          if (state is GetEventSuccess) {
            print('11111123123123');
            return Row(
                children: List.generate(
                    state.events.length,
                    (index) => InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                              StoreScreen.routeName,
                              arguments: state.events[index].store.id),
                          child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: FeaturedItem(
                                  itemtype: ItemType.product,
                                  imgUrl: state.events[index].imgUrl,
                                  content: state.events[index].name)),
                        )));
          }
          return Row(
              children: List.generate(
                  5,
                  (index) => Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: const FeaturedItemSkeleton())));
        });
  }
}
