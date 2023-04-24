import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/model/membership_card.dart';

part 'get_featured_memcard_state.dart';

class GetFeaturedMemcardCubit extends Cubit<GetFeaturedMemcardState> {
  GetFeaturedMemcardCubit() : super(GetFeaturedMemcardInitial());

  Future<void> getMembershipCardContent() async {
    emit(GetFeaturedMemcardLoading());

    await Future.delayed(const Duration(seconds: 1));

    List<MembershipCardModel> cards = [
      MembershipCardModel(
          'Visa', 'assets/images/visa_logo.png', 'Phong Trinh', 18, 12),
      MembershipCardModel(
          'Jollibee', 'assets/images/jollibee_logo.png', 'Phong Trinh', 17, 7),
      MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
          'Phong Trinh', 23, 9)
    ];

    emit(GetFeaturedMemcardSuccess(cards, 6));
  }
}
