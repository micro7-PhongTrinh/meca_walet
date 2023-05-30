import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/bloc/common_cubit/get_featured_stores_cubit.dart';
import 'package:meca_wallet/constants/colors.dart';
import 'package:meca_wallet/features/store/store_screen.dart';

import '../../../widgets/store_card.dart';
import '../../../widgets/tab_title.dart';

class RecommendedStore extends StatelessWidget {
  const RecommendedStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TabTitle(title: 'Phù hợp với bạn'),
        const SizedBox(
          height: 10,
        ),
        BlocProvider<GetFeaturedStoresCubit>(
            create: (_) => GetFeaturedStoresCubit(
                mecaService: RepositoryProvider.of<MecaService>(context))
              ..getFeaturedStores(),
            child: const RecommendStoreBody()),
      ],
    );
  }
}

class RecommendStoreBody extends StatelessWidget {
  const RecommendStoreBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder(
            bloc: BlocProvider.of<GetFeaturedStoresCubit>(context),
            builder: (context, state) {
              if (state is GetFeaturedStoresSuccess) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    state.stores.length,
                    (index) => InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(StoreScreen.routeName,arguments: state.stores[index].id
                        ),
                        child: StoreCard(
                          store: state.stores[index],
                        )),
                  )),
                );
              }
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Container(
                              height: 80,
                              width: 180,
                              color: kSeperatorColor,
                            )),
                  ));
            }));
  }
}
