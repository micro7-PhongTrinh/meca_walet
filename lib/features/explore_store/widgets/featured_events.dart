import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/tab_title.dart';
import '../../store/store_screen.dart';
import '../bloc/get_featured_events_cubit.dart';
import 'featured_item.dart';
import 'featured_item_skeleton.dart';

class FeaturedEvents extends StatelessWidget {
  const FeaturedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetFeaturedEventsCubit>(context).getFeaturedEvents();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
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
    return BlocBuilder<GetFeaturedEventsCubit, GetFeaturedEventsState>(
        bloc: BlocProvider.of<GetFeaturedEventsCubit>(context),
        builder: (context, state) {
          if (state is GetFeaturedEventsSuccess) {
            return Row(
                children: List.generate(
                    state.events.length,
                    (index) => InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(StoreScreen.routeName),
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
