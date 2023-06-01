import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/store.dart';
import 'package:meca_service/meca_service.dart';

part 'get_store_infor_state.dart';

class GetStoreInforCubit extends Cubit<GetStoreInforState> {
  GetStoreInforCubit({required mecaService, required id})
      : _mecaService = mecaService,
        _id = id,
        super(GetStoreInforInitial());

  final MecaService _mecaService;
  final String _id;

  Future<void> getStoreInfor() async {
    emit(GetStoreInforLoading());

    try {
      Store store = await _mecaService.getDetailStore(_id);
      emit(GetStoreInforSuccess(store));
    } catch (e) {
      emit(GetStoreInforFail());
    }
  }
}
