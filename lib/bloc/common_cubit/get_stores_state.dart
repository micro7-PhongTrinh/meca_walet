part of 'get_stores_cubit.dart';

abstract class GetStoresState extends Equatable {
  const GetStoresState();

  @override
  List<Object?> get props => [];
}

class GetStoresInitial extends GetStoresState {}

class GetStoresLoading extends GetStoresState {}

class GetStoresSuccess extends GetStoresState {
  final List<Store> stores;

  const GetStoresSuccess(this.stores);

  @override
  List<Object?> get props => [stores];
}

class GetStoresFail extends GetStoresState {}
