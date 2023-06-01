import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_service/meca_service.dart';

part 'get_memcard_state.dart';

class GetMemcardCubit extends Cubit<GetMemcardState> {
  GetMemcardCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetMemcardInitial());

  final MecaService _mecaService;

  Future<void> getStoreMemcard(String storeId) async {
    emit(GetMemcardLoading());
    try {
      DetailMemberCard? card =
          await _mecaService.getDetailMemberCardByStore(storeId);
      if (card != null) {
        emit(GetMemcardSuccess(card));
      } else {
        emit(NotIntegrateMembership());
      }
    } catch (e) {
      emit(GetMemcardFail());
    }
  }

  Future<void> integrateMemcard(String storeId) async {
    emit(GetMemcardLoading());
    try {
      DetailMemberCard card =
          await _mecaService.createDetailMemberCard(storeId);
      emit(GetMemcardSuccess(card));
    } catch (e) {
      emit(GetMemcardFail());
    }
  }
}
