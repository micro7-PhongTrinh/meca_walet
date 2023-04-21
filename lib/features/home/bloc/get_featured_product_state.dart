part of 'get_featured_product_cubit.dart';

abstract class GetFeaturedProductState extends Equatable {
  const GetFeaturedProductState();

  @override
  List<Object> get props => [];
}

class GetFeaturedProductInitial extends GetFeaturedProductState {}

class GetFeaturedProductLoading extends GetFeaturedProductState {}

class GetFeaturedProductSuccess extends GetFeaturedProductState {
  final List<FeaturedProductModel> products;

  const GetFeaturedProductSuccess(this.products);
}

class GetFeaturedProductFail extends GetFeaturedProductState {}
