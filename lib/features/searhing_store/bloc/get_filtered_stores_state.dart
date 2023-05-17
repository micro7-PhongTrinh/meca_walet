part of 'get_filtered_stores_cubit.dart';

abstract class GetFilteredStoresState extends Equatable {
  const GetFilteredStoresState();

  @override
  List<Object?> get props => [];
}

class GetFilteredStoresInitial extends GetFilteredStoresState {}

class GetFilteredStoresLoading extends GetFilteredStoresState {}

class GetFilteredStoresSuccess extends GetFilteredStoresState {
  final List<StoreModel> stores;

  const GetFilteredStoresSuccess(this.stores);

  @override
  List<Object?> get props => [stores];
}

class GetFilteredStoresFail extends GetFilteredStoresState {}
