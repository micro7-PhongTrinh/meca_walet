import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/features/store/bloc/get_product_cubit.dart';
import '../store_screen.dart';
import 'store_box_content.dart';
import 'store_product_card.dart';

class StoreProducts extends StatelessWidget {
  const StoreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 32),
        child: const StoreBoxContent(
            title: 'Sản phẩm nổi bật', widget: ListProduct()));
  }
}

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetProductCubit>(context)
        .getStoreProduct(StoreValue.of(context).store.id.toString());
    return BlocBuilder<GetProductCubit, GetProductState>(
        bloc: BlocProvider.of<GetProductCubit>(context),
        builder: (context, state) {
          if (state is GetProductSuccess) {
            return Column(
              children: List.generate(state.products.length,
                  (index) => StoreProductCard(product: state.products[index])),
            );
          }
          return Container();
        });
  }
}
