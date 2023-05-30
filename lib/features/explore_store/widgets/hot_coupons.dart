import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/explore_store/bloc/get_hot_coupons_cubit.dart';

import '../../../widgets/tab_title.dart';
import '../../store/store_screen.dart';
import 'featured_item.dart';
import 'featured_item_skeleton.dart';

class HotCoupons extends StatelessWidget {
  const HotCoupons({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetHotCoupounsCubit>(context).getHotCoupouns();
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(title: 'Ưu đãi hấp dẫn', padding: 0),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: HotCouponItems())
      ],
    );
  }
}

class HotCouponItems extends StatelessWidget {
  const HotCouponItems({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHotCoupounsCubit, GetHotCoupounsState>(
        bloc: BlocProvider.of<GetHotCoupounsCubit>(context),
        builder: (context, state) {
          if (state is GetHotCoupounsSuccess) {
            return Row(
                children: List.generate(
                    state.coupons.length,
                    (index) => InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(StoreScreen.routeName),
                          child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: FeaturedItem(
                                  itemtype: ItemType.product,
                                  imgUrl: state.coupons[index].imgUrl,
                                  content: state.coupons[index].name)),
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
