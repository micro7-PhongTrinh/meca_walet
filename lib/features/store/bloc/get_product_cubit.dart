import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/product.dart';
import 'package:meca_service/meca_service.dart';


part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit({required mecaService}) : _mecaService = mecaService, super(GetProductInitial());

final MecaService _mecaService;

  Future<void> getStoreProduct(String storeId) async {
    List<Product> products = await _mecaService.getStoreProducts(storeId);
    emit(GetProductSuccess(products));
  }
}
