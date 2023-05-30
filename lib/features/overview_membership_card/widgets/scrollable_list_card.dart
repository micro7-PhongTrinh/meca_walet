import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/member_card.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_memcard_cubit.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/widgets/error/list_memcard_error.dart';
import 'package:meca_wallet/widgets/skeleton/list_membership_card_skeleton.dart';

import '../../../widgets/membership_store_card.dart';
import '../../detail_memberhsip_card/detail_membership_card_screen.dart';

class ScrollableListCard extends StatelessWidget {
  const ScrollableListCard({super.key});

  @override
  Widget build(BuildContext context) {
    GetFeaturedMemcardCubit cubit =
        BlocProvider.of<GetFeaturedMemcardCubit>(context);
    cubit.getAllMembershipCards();

    return BlocBuilder<GetFeaturedMemcardCubit, GetFeaturedMemcardState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state is GetFeaturedMemcardSuccess) {
            return ListCardHolder(cards: state.cards);
          }
          if (state is GetFeaturedMemcardFail) {
            return const ListMemcardError();
          }
          return const ListMemcardSkeleton();
        }));
  }
}

class ListCardHolder extends StatelessWidget {
  final List<MemberCard> cards;
  const ListCardHolder({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Align(
          child: SizedBox(
            height: 260,
            child: MembershipStoreCard(
                key: ValueKey('memcard-${index.toString()}'),
                card: cards[index]),
          ),
        );
      },
      fade: 0,
      viewportFraction: 0.9,
      autoplayDelay: 1000,
      onIndexChanged: (index) {},
      onTap: (index) {
        Navigator.of(context).pushNamed(DetailMembershipCardScreen.routeName);
      },
      itemCount: 2,
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: kFillColorThird, activeColor: kPrimaryPurple),
          margin: EdgeInsets.all(5.0)),
    );
  }
}
