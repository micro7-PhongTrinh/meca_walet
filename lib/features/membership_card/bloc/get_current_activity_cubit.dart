import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/card_activity_model.dart';

part 'get_current_activity_state.dart';

class GetCurrentActivityCubit extends Cubit<GetCurrentActivityState> {
  GetCurrentActivityCubit() : super(GetCurrentActivityInitial());

  Future<void> getCurrentActivities() async {
    emit(GetCurrentActivityLoading());

    await Future.delayed(const Duration(seconds: 1));

    List<CardActivityModel> activities = [
      CardActivityModel(
          'Jollibee',
          'https://www.clipartmax.com/png/middle/133-1332451_jollibee-clipart-classic-jollibee-fast-food-logo.png',
          'Mua hàng thành công',
          2),
      CardActivityModel(
          'Mini Stop',
          'https://cdn.freebiesupply.com/logos/large/2x/mini-stop-logo-png-transparent.png',
          'Mở thẻ thành viên',
          1),
      CardActivityModel(
          'Circle K',
          'https://e7.pngegg.com/pngimages/157/520/png-clipart-circle-k-retail-convenience-shop-business-franchising-business-text-rectangle-thumbnail.png',
          'Mua hàng thành công',
          1),
      CardActivityModel(
          'Jollibee',
          'https://www.clipartmax.com/png/middle/133-1332451_jollibee-clipart-classic-jollibee-fast-food-logo.png',
          'Mở thẻ thành viên',
          1),
      CardActivityModel(
          'Starbucks',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcLgB_TDiHpxjkxG0_JEKLO7kddGqo-XrzgQ&usqp=CAU',
          'Mua hàng thành công',
          1),
    ];

    emit(GetCurrentActivitySuccess(activities));
  }
}
