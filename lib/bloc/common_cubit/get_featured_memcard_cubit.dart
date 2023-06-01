import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/detail_member_card.dart';
import 'package:meca_service/data/featured_member_card.dart';
import 'package:meca_service/meca_service.dart';

part 'get_featured_memcard_state.dart';

class GetFeaturedMemcardCubit extends Cubit<GetFeaturedMemcardState> {
  GetFeaturedMemcardCubit({required mecaService})
      : _mecaService = mecaService,
        super(GetFeaturedMemcardInitial()) {
    _mecaService.memcard.listen((memcard) {
      getFeaturedMemberCards();
    });
  }

  final MecaService _mecaService;

  Future<void> getFeaturedMemberCards() async {
    emit(GetFeaturedMemcardLoading());

    FeaturedMemberCard featuredCards =
        await _mecaService.getFeaturedDetailMemberCards();
    try {
      if (featuredCards.cards.isEmpty) {
        emit(EmptyMemcard());
      } else {
        emit(GetFeaturedMemcardSuccess(
            featuredCards.cards, featuredCards.total));
      }
    } catch (e) {
      emit(GetFeaturedMemcardFail());
    }
  }

  Future<void> getAllMembershipCards() async {
    emit(GetFeaturedMemcardLoading());
    List<DetailMemberCard> cards =
        await _mecaService.getAllDetailMemberCards();

    emit(GetMemcardSuccess(cards));
  }
}
