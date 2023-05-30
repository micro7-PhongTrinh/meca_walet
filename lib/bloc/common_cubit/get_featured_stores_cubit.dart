import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/store.dart';
import 'package:meca_service/meca_service.dart';

part 'get_featured_stores_state.dart';

class GetFeaturedStoresCubit extends Cubit<GetFeaturedStoresState> {
  GetFeaturedStoresCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetFeaturedStoresInitial());

  final MecaService _mecaService;

  Future<void> getFeaturedStores() async {
    emit(GetFeaturedStoresLoading());
    await Future.delayed(const Duration(seconds: 1));
    List<Store> stores = await _mecaService.getFeaturedStores();

    emit(GetFeaturedStoresSuccess(stores));
  }
}
