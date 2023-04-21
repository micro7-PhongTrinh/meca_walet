import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meca_wallet/features/home/bloc/get_featured_memcard_cubit.dart';

import '../../widgets/error/featured_memcard_error.dart';
import '../../widgets/membership_store_card.dart';
import '../../widgets/membership_store_more_card.dart';
import '../../widgets/skeleton/membership_card_skeleton.dart';
import '../../widgets/tab_title.dart';

class FeaturedMembershipCard extends StatelessWidget {
  const FeaturedMembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GetFeaturedMemcardCubit()..getMembershipCardContent(),
        child: Column(
          children: [
            TabTitle(
              title: 'Ví thành viên',
              actionText: 'Tất cả',
              seeAll: () {
                Navigator.of(context).pushNamed('/membershipCardScreen');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const FeaturedMembershipCardBody()
          ],
        ));
  }
}

class FeaturedMembershipCardBody extends StatelessWidget {
  const FeaturedMembershipCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        //FeaturedMembershipCardHeader(),
        FeaturedMembershipCardHolder()
      ],
    );
  }
}

class FeaturedMembershipCardHeader extends StatelessWidget {
  const FeaturedMembershipCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/membershipCardScreen');
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Tất cả'),
            SvgPicture.asset('assets/icons/see_all_button.svg')
          ],
        ));
  }
}

class FeaturedMembershipCardHolder extends StatelessWidget {
  const FeaturedMembershipCardHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFeaturedMemcardCubit, GetFeaturedMemcardState>(
        builder: ((context, state) {
      if (state is GetFeaturedMemcardSuccess) {
        return IntrinsicHeight(
            child: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Container(),
            ...List.generate(
                state.cards.length - 1,
                (index) => Container(
                    margin: EdgeInsets.only(top: 72.0 * index),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MembershipStoreCard(card: state.cards[index])))),
            Container(
                margin: const EdgeInsets.only(top: 72.0 * 2),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(children: [
                      MembershipStoreCard(
                          card: state.cards[state.cards.length - 1]),
                      MembershipStoreMoreCard(
                          otherCardsnumber:
                              state.cardTotal - state.cards.length),
                    ])))
          ],
        ));
      } else if (state is GetFeaturedMemcardFail) {
        return const FeaturedMemcardError();
      }
      return const MembershipCardSkeleton();
    }));
  }
}
