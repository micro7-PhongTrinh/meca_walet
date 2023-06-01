import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_service/meca_service.dart';

part 'get_detail_memcard_state.dart';

class GetDetailMemcardCubit extends Cubit<GetDetailMemcardState> {
  GetDetailMemcardCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetDetailMemcardInitial());

  final MecaService _mecaService;

  Future<void> getDetailMemcardByCard(String cardId) async {
    emit(GetDetailMemcardLoading());
    try {
      DetailMemberCard card = await _mecaService.getDetailMemberCardByCard(cardId);
        emit(GetDetailMemcardSuccess(card));

    } catch (e) {
      emit(GetDetailMemcardFail());
    }
  }
}
