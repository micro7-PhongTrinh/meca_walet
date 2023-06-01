import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/store/bloc/get_memcard_cubit.dart';

import '../../../bloc/common_cubit/get_featured_memcard_cubit.dart';
import '../../../widgets/tab_title.dart';
import '../../../widgets/error/featured_memcard_error.dart';
import '../../../widgets/membership_store_card.dart';
import '../../../widgets/membership_store_more_card.dart';
import '../../../widgets/skeleton/membership_card_skeleton.dart';

class FeaturedMembershipCard extends StatelessWidget {
  const FeaturedMembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GetFeaturedMemcardCubit(
            mecaService: RepositoryProvider.of<MecaService>(context)),
        child: const Column(
          children: [
            FeaturedMembershipCardHeader(),
            SizedBox(
              height: 25,
            ),
            FeaturedMembershipCardBody()
          ],
        ));
  }
}

class FeaturedMembershipCardBody extends StatelessWidget {
  const FeaturedMembershipCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetFeaturedMemcardCubit>(context).getFeaturedMemberCards();
    return const FeaturedMembershipCardHolder();
  }
}

class FeaturedMembershipCardHeader extends StatelessWidget {
  const FeaturedMembershipCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFeaturedMemcardCubit, GetFeaturedMemcardState>(
      builder: (context, state) {
        if (state is GetFeaturedMemcardSuccess) {
          return TabTitle(
            title: 'Ví thành viên',
            actionText: 'Tất cả',
            seeAll: () {
              Navigator.of(context).pushNamed('/membershipCardScreen');
            },
          );
        }
        return const TabTitle(title: 'Ví thành viên');
      },
    );
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
                state.cardTotal <= 3
                    ? state.cards.length
                    : 3,
                (index) => Container(
                    margin: EdgeInsets.only(top: 72.0 * index),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: MembershipStoreCard(detailCard: state.cards[index])))),
            if (state.cardTotal > 3)
              Container(
                  margin: const EdgeInsets.only(top: 72.0 * 2),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Stack(children: [
                        MembershipStoreCard(
                            detailCard: state.cards[state.cards.length - 1]),
                        MembershipStoreMoreCard(
                            otherCardsnumber:
                                state.cardTotal - state.cards.length),
                      ])))
          ],
        ));
      } else if (state is EmptyMemcard) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 18),
                SizedBox(
                    height: 108,
                    width: 108,
                    child: Image.asset(
                        color: kTextColorAccent,
                        fit: BoxFit.fill,
                        'assets/images/empty-box.png')),
                const SizedBox(height: 24),
                const Text(
                  'Ví thành viên rỗng. \nTích lũy thêm thẻ thành viên với Meca!',
                  style: TextStyle(color: kTextColorAccent, fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ));
      } else if (state is GetFeaturedMemcardFail) {
        return const FeaturedMemcardError();
      }
      return const MembershipCardSkeleton();
    }));
  }
}
