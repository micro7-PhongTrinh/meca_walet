import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/home/bloc/get_featured_product_cubit.dart';
import 'package:meca_wallet/widgets/featured_product_card.dart';

import '../../../widgets/error/featured_product_error.dart';
import '../../../widgets/selected_text_button.dart';
import '../../../widgets/skeleton/featured_product_skeleton.dart';
import '../../../widgets/tab_title.dart';

// nay hien thi danh muc theo cac danh muc san pham cua cac cua hang
class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetFeaturedProductCubit>(
        create: (_) => GetFeaturedProductCubit(),
        child: Column(
          children: [
            const TabTitle(title: 'Danh mục nổi bật'),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: FeaturedProductBody(categories)),
          ],
        ));
  }
}

class FeaturedProductBody extends StatefulWidget {
  const FeaturedProductBody(this.categories, {super.key});

  final List<String> categories;

  @override
  State<FeaturedProductBody> createState() => _FeaturedProductBodyState();
}

class _FeaturedProductBodyState extends State<FeaturedProductBody> {
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<GetFeaturedProductCubit>(context)
        .getFilteredProducts(widget.categories[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SingleChildScrollView(
        key: const Key('tategory_filter_tab'),
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              widget.categories.length,
              (index) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: SelectedTextButton(
                      key: Key('tategory_filter_tab_$index'),
                      widget.categories[index],
                      selectedIndex == index, () {
                    setState(() {
                      selectedIndex = index;
                      var getProductBloc =
                          BlocProvider.of<GetFeaturedProductCubit>(context);
                      getProductBloc
                          .getFilteredProducts(widget.categories[index]);
                    });
                  })),
            )),
      ),
      const SizedBox(height: 8),
      const _ProductScrollList()
    ]);
  }
}

class _ProductScrollList extends StatelessWidget {
  const _ProductScrollList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('tategory_product_tab'),
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<GetFeaturedProductCubit, GetFeaturedProductState>(
        builder: (context, state) {
          if (state is GetFeaturedProductSuccess) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    state.products.length,
                    (index) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushNamed('/storeScreen'),
                              child: FeaturedProductCard(
                                  key: Key('tategory_product_tab_$index'),
                                  product: state.products[index])),
                        )));
          } else if (state is GetFeaturedProductFail) {
            return const FeaturedProductError();
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => const FeaturedProductSkeleton(),
              ));
        },
      ),
    );
  }
}
