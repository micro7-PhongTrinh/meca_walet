import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/coupon_model.dart';

part 'get_hot_coupons_state.dart';

class GetHotCoupounsCubit extends Cubit<GetHotCoupounsState> {
  GetHotCoupounsCubit() : super(GetHotCoupounsInitial());

  Future<void> getHotCoupouns() async {
    emit(GetHotCoupounsLoading());
    print('1123');
    await Future.delayed(const Duration(seconds: 1));
    List<CoupounModel> coupons = List.generate(
        4,
        (index) => CoupounModel('Giảm 5% khi mua thức uống tại cửa hàng', '123',
            'https://t.pimg.jp/050/711/330/1/50711330.jpg'));

    emit(GetHotCoupounsSuccess(coupons));
  }
}
