import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_wallet/model/membership_card.dart';

import '../../constants/colors.dart';

part 'get_featured_memcard_state.dart';

class GetFeaturedMemcardCubit extends Cubit<GetFeaturedMemcardState> {
  GetFeaturedMemcardCubit() : super(GetFeaturedMemcardInitial());

  Future<void> getMembershipCardContent() async {
    emit(GetFeaturedMemcardLoading());

    await Future.delayed(const Duration(seconds: 1));

    List<MembershipCardModel> cards = [
      MembershipCardModel('Visa', 'assets/images/visa_logo.png', 'Phong Trinh',
          18, 12, cardColors[0]),
      MembershipCardModel('Jollibee', 'assets/images/jollibee_logo.png',
          'Phong Trinh', 17, 7, cardColors[1]),
      MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
          'Phong Trinh', 23, 9, cardColors[2]),
      MembershipCardModel('Visa', 'assets/images/visa_logo.png', 'Phong Trinh',
          18, 12, cardColors[3]),
      MembershipCardModel('Jollibee', 'assets/images/jollibee_logo.png',
          'Phong Trinh', 17, 7, cardColors[4]),
      MembershipCardModel('Krispy Kreme', 'assets/images/krispy_kreme_logo.png',
          'Phong Trinh', 23, 9, cardColors[5])
    ];

    emit(GetFeaturedMemcardSuccess(cards, 6));
  }
}
