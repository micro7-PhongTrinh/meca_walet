import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/common_cubit/get_stores_cubit.dart';
import '../../../constants/colors.dart';
import '../../../widgets/tab_title.dart';
import '../../store/store_screen.dart';
import 'suggest_item.dart';
import 'suggest_item_skeleton.dart';

class SearchingStoreResult extends StatelessWidget {
  const SearchingStoreResult({super.key, required this.searchString});

  final String searchString;

  @override
  Widget build(BuildContext context) {
    GetStoresCubit cubit =
        BlocProvider.of<GetStoresCubit>(context);
    cubit.getFilteredStores(searchString);

    return SingleChildScrollView(
        child: Column(children: [
      const SizedBox(height: 45),
      const TabTitle(title: 'Tìm kiếm phù hợp', color: kPrimaryPurple),
      const SizedBox(height: 15),
      FilteredStoreBody(cubit: cubit)
    ]));
  }
}

class FilteredStoreBody extends StatelessWidget {
  const FilteredStoreBody({
    super.key,
    required this.cubit,
  });

  final GetStoresCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStoresCubit, GetStoresState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is GetStoresSuccess) {
            return Column(
              children: List.generate(
                  state.stores.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                StoreScreen.routeName,
                                arguments: state.stores[index].id),
                            child: SuggestItem(store: state.stores[index])),
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
