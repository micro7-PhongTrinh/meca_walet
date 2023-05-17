part of 'get_featured_stores_cubit.dart';

abstract class GetFeaturedStoresState extends Equatable {
  const GetFeaturedStoresState();
  

  @override
  List<Object?> get props => [];
}

class GetFeaturedStoresInitial extends GetFeaturedStoresState {}

class GetFeaturedStoresLoading extends GetFeaturedStoresState {}

class GetFeaturedStoresSuccess extends GetFeaturedStoresState {
  final List<StoreModel> stores;

  const GetFeaturedStoresSuccess(this.stores);

  @override
  List<Object?> get props => [stores];
}

class GetFeaturedStoresFail extends GetFeaturedStoresState {}
