import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../widgets/tab_title.dart';
import '../bloc/get_filtered_stores_cubit.dart';
import 'suggest_item.dart';
import 'suggest_item_skeleton.dart';

class StoreSuggest extends StatelessWidget {
  const StoreSuggest({super.key});

  @override
  Widget build(BuildContext context) {
    GetFilteredStoresCubit cubit =
        BlocProvider.of<GetFilteredStoresCubit>(context);
    cubit.getSuggestStores();
    return SingleChildScrollView(
        child: Column(children: [
      const SizedBox(height: 45),
      const TabTitle(title: 'Các gợi ý cửa hàng', color: kPrimaryPurple),
      const SizedBox(height: 15),
      SuggestStoreBody(cubit: cubit)
    ]));
  }
}

class SuggestStoreBody extends StatelessWidget {
  const SuggestStoreBody({
    super.key,
    required this.cubit,
  });

  final GetFilteredStoresCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFilteredStoresCubit, GetFilteredStoresState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is GetFilteredStoresSuccess) {
            return Column(
              children: List.generate(
                  state.stores.length,
                  (index) => const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: SuggestItem(),
                      )),
            );
          }
          return Column(
            children: List.generate(
                10,
                (index) => const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: SuggestItemSkeleton(),
                    )),
          );
        });
  }
}
