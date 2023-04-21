import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/featured_product.dart';
part 'get_featured_product_state.dart';

class GetFeaturedProductCubit extends Cubit<GetFeaturedProductState> {
  //late final StorageService service;
  GetFeaturedProductCubit() : super(GetFeaturedProductInitial());

  Future<void> getFilteredProducts(String filter) async {
    emit(GetFeaturedProductLoading());

    //process get product list from StorageService service
    await Future.delayed(const Duration(seconds: 1));
    List<FeaturedProductModel> products = [
      FeaturedProductModel(
          'Trà sữa thạch đen',
          'https://cdn.cet.edu.vn/wp-content/uploads/2018/04/tra-sua-tu-lam.jpg',
          'Tiệm trà dưa lưới',
          4.6),
      FeaturedProductModel(
          'Bò sốt phô mai',
          'https://cdn.tgdd.vn/2022/05/CookRecipe/GalleryStep/thanh-pham-35.jpg',
          'Bò sốt hẻm',
          4.2),
      FeaturedProductModel(
          'Bánh tráng mâm',
          'https://cdn3.ivivu.com/2020/03/banh-trang-mam-va-nhung-mon-an-vat-hut-gioi-tre-tphcm-ivivu-1.jpg',
          'Ăt vặt BN',
          5.0),
      FeaturedProductModel(
          'Trà sữa xanh',
          'https://wiki-travel.com.vn/uploads/picture/camnhi-204709054754-bap-xao.jpg',
          'Tiệm trà dưa lưới',
          4.3)
    ];
    emit(GetFeaturedProductSuccess(products));
  }
}
