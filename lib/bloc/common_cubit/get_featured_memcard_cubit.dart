import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/data/member_card.dart';
import 'package:meca_service/data/featured_member_card.dart';
import 'package:meca_service/meca_service.dart';
import 'package:meca_wallet/features/store/bloc/get_memcard_cubit.dart';

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

    await Future.delayed(const Duration(seconds: 1));

    FeaturedMemberCard featuredCards =
        await _mecaService.getFeaturedMemberCards();
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

    await Future.delayed(const Duration(seconds: 1));

    FeaturedMemberCard featuredCards =
        await _mecaService.getFeaturedMemberCards();

    emit(GetFeaturedMemcardSuccess(featuredCards.cards, featuredCards.total));
  }
}
