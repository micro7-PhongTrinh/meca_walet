import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../model/membership_card.dart';

part 'get_memcard_state.dart';

class GetMemcardCubit extends Cubit<GetMemcardState> {
  GetMemcardCubit() : super(GetMemcardInitial());

  Future<void> getStoreMemcard(String storeId) async {
    await Future.delayed(Duration(seconds: 1));
    emit(GetMemcardSuccess(
      MembershipCardModel('Cheese Coffee', 'assets/images/jollibee_logo.png',
          'Phong Trinh', 21, 3, cardColors[0]),
    ));
  }
}
