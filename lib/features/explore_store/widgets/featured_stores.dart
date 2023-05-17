import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/explore_store/explore_store_screen.dart';
import 'package:meca_wallet/features/explore_store/widgets/featured_item_skeleton.dart';

import '../../../widgets/tab_title.dart';
import '../../store/store_screen.dart';
import '../bloc/get_featured_stores_cubit.dart';
import 'featured_item.dart';

class FeaturedStores extends StatelessWidget {
  const FeaturedStores({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<GetFeaturedStoresCubit>(context);
    cubit.getFeaturedStores();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
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
    return BlocBuilder<GetFeaturedStoresCubit, GetFeaturedStoresState>(
        bloc: BlocProvider.of<GetFeaturedStoresCubit>(context),
        builder: (context, state) {
          if (state is GetFeaturedStoresSuccess) {
            return Row(
                children: List.generate(
                    state.stores.length,
                    (index) => InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(StoreScreen.routeName),
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
