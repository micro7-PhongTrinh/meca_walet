import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/home/bloc/get_featured_product_bloc.dart';
import 'package:meca_wallet/widgets/featured_product_card.dart';

import '../../constants/colors.dart';
import '../../widgets/selected_text_button.dart';
import '../../widgets/tab_title.dart';

// nay hien thi danh muc theo cac danh muc san pham cua cac cua hang
class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetFeaturedProductBloc>(
        create: (_) =>
            GetFeaturedProductBloc()..getFilteredProducts(categories[0]),
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
                child: _FeaturedProductBody(categories)),
          ],
        ));
  }
}

class _FeaturedProductBody extends StatefulWidget {
  const _FeaturedProductBody(this.categories);

  final List<String> categories;

  @override
  State<_FeaturedProductBody> createState() => _FeaturedProductBodyState();
}

class _FeaturedProductBodyState extends State<_FeaturedProductBody> {
  int selectedIndex = 0;

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
                          BlocProvider.of<GetFeaturedProductBloc>(context);
                      getProductBloc.getFilteredProducts(index.toString());
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
      child: BlocBuilder<GetFeaturedProductBloc, GetFeaturedProductState>(
        builder: (context, state) {
          if (state is GetFeaturedProductSuccess) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  state.products.length,  
                  (index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: FeaturedProductCard(
                          key: Key('tategory_product_tab_$index'),
                          product: state.products[index])),
                ));
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => Container(
                  height: 160,
                  width: 112,
                  margin: const EdgeInsets.only(right: 8),
                  color: kFillColorPrimary,
                ),
              ));
        },
      ),
    );
  }
}
