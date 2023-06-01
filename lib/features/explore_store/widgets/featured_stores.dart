import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item_skeleton.dart';

import '../../../bloc/common_cubit/get_stores_cubit.dart';
import '../../../widgets/tab_title.dart';
import '../../store/store_screen.dart';
import 'featured_item.dart';

class FeaturedStores extends StatelessWidget {
  const FeaturedStores({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<GetStoresCubit>(context);
    cubit.getFeaturedStores();
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle(title: 'Cửa hàng nổi bật', padding: 0),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: FeaturedStoreItems())
      ],
    );
  }
}

class FeaturedStoreItems extends StatelessWidget {
  const FeaturedStoreItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStoresCubit, GetStoresState>(
        bloc: BlocProvider.of<GetStoresCubit>(context),
        builder: (context, state) {
          if (state is GetStoresSuccess) {
            return Row(
                children: List.generate(
                    state.stores.length,
                    (index) => InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                              StoreScreen.routeName,
                              arguments: state.stores[index].id),
                          child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: FeaturedItem(
                                  itemtype: ItemType.store,
                                  imgUrl: state.stores[index].logoUrl,
                                  storeName: state.stores[index].name,
                                  content:
                                      '${state.stores[index].memberNumber} thành viên')),
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
