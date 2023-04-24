import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_memcard_cubit.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:meca_wallet/model/membership_card.dart';

import '../../../widgets/error/featured_memcard_error.dart';
import '../../../widgets/membership_store_card.dart';
import '../../../widgets/skeleton/membership_card_skeleton.dart';

class ScrollableListCard extends StatelessWidget {
  const ScrollableListCard({super.key});

  @override
  Widget build(BuildContext context) {
    GetFeaturedMemcardCubit cubit =
        BlocProvider.of<GetFeaturedMemcardCubit>(context);
    cubit.getMembershipCardContent();

    return BlocBuilder(
        bloc: cubit,
        builder: ((context, state) {
          if (state is GetFeaturedMemcardSuccess) {
            return ListCardHolder(cards: state.cards);
          }
          if (state is GetFeaturedMemcardFail) {
            return const FeaturedMemcardError();
          }
          return const MembershipCardSkeleton();
        }));
  }
}

class ListCardHolder extends StatelessWidget {
  final List<MembershipCardModel> cards;
  const ListCardHolder({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return MembershipStoreCard(card: cards[index]);
        },
        itemWidth: MediaQuery.of(context).size.width * 0.86,
        itemHeight: 260,
        layout: SwiperLayout.STACK,
        scrollDirection: Axis.vertical,
        onTap: (index) {
          print(index.toString());
        },
        itemCount: cards.length);
  }
}
