import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/features/home/bloc/get_featured_product_cubit.dart';
import 'package:meca_wallet/features/store/store_screen.dart';
import 'package:meca_wallet/widgets/featured_product_card.dart';
import 'package:meca_wallet/widgets/rating_star.dart';

import '../../../constants/colors.dart';
import '../../../widgets/error/featured_product_error.dart';
import '../../../widgets/selected_text_button.dart';
import '../../../widgets/skeleton/featured_product_skeleton.dart';
import '../../../widgets/store_avatar.dart';
import '../../../widgets/tab_title.dart';

// nay hien thi danh muc theo cac danh muc san pham cua cac cua hang
class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({super.key});

  // import category from outside make testable
  final List<String> categories = const [
    'Quần áo',
    'Coffee',
    'Nhà hàng',
    'Mua sắm',
    'Ăn vặt',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetFeaturedProductCubit>(
        create: (_) => GetFeaturedProductCubit(
            mecaService: RepositoryProvider.of<MecaService>(context)),
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
                              onTap: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                      insetAnimationDuration:
                                          const Duration(seconds: 1),
                                      insetPadding: EdgeInsets.zero,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: state
                                                      .products[index].imgUrl,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Container(
                                                          color:
                                                              kTextColorAccent),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  state
                                                                      .products[
                                                                          index]
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                              const RatingStar(
                                                                  ratePoint: 4),
                                                            ],
                                                          )),
                                                      const SizedBox(height: 5),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              StoreAvatar(
                                                                  logoUrl: state
                                                                      .products[
                                                                          index]
                                                                      .store
                                                                      .logoUrl),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    state
                                                                        .products[
                                                                            index]
                                                                        .store
                                                                        .name,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
                                                                  const Text(
                                                                      '45 thành viên'),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              TextButton(
                                                                  onPressed: () => Navigator.of(context).pushNamed(
                                                                      StoreScreen
                                                                          .routeName,
                                                                      arguments: state
                                                                          .products[
                                                                              index]
                                                                          .store
                                                                          .id),
                                                                  child: const Text(
                                                                      'Truy cập'))
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
