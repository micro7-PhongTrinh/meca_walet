part of 'get_product_cubit.dart';

abstract class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object?> get props => [];
}

class GetProductInitial extends GetProductState {}

class GetProductLoading extends GetProductState {}

class GetProductSuccess extends GetProductState {
  final List<FeaturedProductModel> products;

  const GetProductSuccess(this.products);
}

class GetProductFail extends GetProductState {}
