import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/featured_product.dart';
import '../../../model/product_model.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit() : super(GetProductInitial());

  Future<void> getStoreProduct(String storeId) async {
    await Future.delayed(Duration(seconds: 1));
    emit(GetProductSuccess(List.generate(
      4,
      (index) => FeaturedProductModel(
          ProductModel(
              '123123',
              'Bò sốt phô mai',
              'https://cdn.tgdd.vn/2022/05/CookRecipe/GalleryStep/thanh-pham-35.jpg',
              4.2),
          'https://botonhanphat.vn/wp-content/uploads/2021/10/Logo-Facebook_He%CC%A3%CC%82-Tho%CC%82%CC%81ng-Bo%CC%80-To%CC%9B-Nha%CC%82n-Pha%CC%81t.png',
          'Bò sốt hẻm'),
    )));
  }
}
