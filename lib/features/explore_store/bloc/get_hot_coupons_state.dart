part of 'get_hot_coupons_cubit.dart';

abstract class GetHotCoupounsState extends Equatable {
  const GetHotCoupounsState();
  

  @override
  List<Object?> get props => [];
}

class GetHotCoupounsInitial extends GetHotCoupounsState {}

class GetHotCoupounsLoading extends GetHotCoupounsState {}

class GetHotCoupounsSuccess extends GetHotCoupounsState {
  final List<CoupounModel> coupons;

  const GetHotCoupounsSuccess(this.coupons);

  @override
  List<Object?> get props => [coupons];
}

class GetHotCoupounsFail extends GetHotCoupounsState {}
