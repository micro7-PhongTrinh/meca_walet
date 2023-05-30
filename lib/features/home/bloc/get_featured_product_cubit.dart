import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/product.dart';
import 'package:meca_service/meca_service.dart';

part 'get_featured_product_state.dart';

class GetFeaturedProductCubit extends Cubit<GetFeaturedProductState> {
  //late final StorageService service;
  GetFeaturedProductCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetFeaturedProductInitial());

  final MecaService _mecaService;

  Future<void> getFilteredProducts(String filter) async {
    emit(GetFeaturedProductLoading());

    //process get product list from StorageService service
    await Future.delayed(const Duration(seconds: 1));
    List<Product> products = await _mecaService.getFeaturedProducts();

    emit(GetFeaturedProductSuccess(products));
  }
}
