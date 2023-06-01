import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/store.dart';
import 'package:meca_service/meca_service.dart';

part 'get_stores_state.dart';

class GetStoresCubit extends Cubit<GetStoresState> {
  GetStoresCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetStoresInitial());

  final MecaService _mecaService;

  Future<void> getFeaturedStores() async {
    emit(GetStoresLoading());
    List<Store> stores = await _mecaService.getFeaturedStores();

    emit(GetStoresSuccess(stores));
  }

  Future<void> getSuggestStores() async {
    emit(GetStoresLoading());
    List<Store> stores = await _mecaService.getSuggestStores();

    emit(GetStoresSuccess(stores));
  }

  Future<void> getFilteredStores(String searchString) async {
    emit(GetStoresLoading());
    List<Store> stores = await _mecaService.getFilteredStores(searchString);

    emit(GetStoresSuccess(stores));
  }  
}
