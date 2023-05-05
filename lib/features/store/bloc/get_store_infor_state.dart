part of 'get_store_infor_cubit.dart';

abstract class GetStoreInforState extends Equatable {
  const GetStoreInforState();

  @override
  List<Object?> get props => [];
}

class GetStoreInforInitial extends GetStoreInforState {}

class GetStoreInforLoading extends GetStoreInforState {}

class GetStoreInforSuccess extends GetStoreInforState {
  final StoreModel store;

  const GetStoreInforSuccess(this.store);
}

class GetStoreInforFail extends GetStoreInforState {}
