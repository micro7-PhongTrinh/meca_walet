import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/model/product_model.dart';

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
          ProductModel(
              '123123',
              'Trà sữa thạch đen',
              'https://cdn.cet.edu.vn/wp-content/uploads/2018/04/tra-sua-tu-lam.jpg',
              4.6),
          'https://img5.thuthuatphanmem.vn/uploads/2022/01/13/logo-cua-hang-tra-sua_082029941.jpg',
          'Tiệm trà dưa lưới'),
      FeaturedProductModel(
        ProductModel(
            '123123',
            'Bò sốt phô mai',
            'https://cdn.tgdd.vn/2022/05/CookRecipe/GalleryStep/thanh-pham-35.jpg',
            4.2),
        'https://botonhanphat.vn/wp-content/uploads/2021/10/Logo-Facebook_He%CC%A3%CC%82-Tho%CC%82%CC%81ng-Bo%CC%80-To%CC%9B-Nha%CC%82n-Pha%CC%81t.png',
        'Bò sốt hẻm',
      ),
      FeaturedProductModel(
        ProductModel(
            '123123',
            'Bánh tráng mâm',
            'https://cdn3.ivivu.com/2020/03/banh-trang-mam-va-nhung-mon-an-vat-hut-gioi-tre-tphcm-ivivu-1.jpg',
            5.0),
        'https://ttagencyads.com/wp-content/uploads/2022/01/10-do-an-vat-dep-1-1.jpg',
        'Ăt vặt BN',
      ),
      FeaturedProductModel(
        ProductModel(
            '123123',
            'Trà sữa xanh',
            'https://wiki-travel.com.vn/uploads/picture/camnhi-204709054754-bap-xao.jpg',
            4.3),
        'https://img5.thuthuatphanmem.vn/uploads/2022/01/12/mau-logo-quan-cafe-ngon_095348066.jpg',
        'Tiệm trà dưa lưới',
      )
    ];
    emit(GetFeaturedProductSuccess(products));
  }
}
