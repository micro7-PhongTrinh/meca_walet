part of 'get_featured_memcard_cubit.dart';

abstract class GetFeaturedMemcardState extends Equatable {
  const GetFeaturedMemcardState();

  @override
  List<Object?> get props => [];
}

class GetFeaturedMemcardInitial extends GetFeaturedMemcardState {}

class GetFeaturedMemcardLoading extends GetFeaturedMemcardState {}

class GetFeaturedMemcardSuccess extends GetFeaturedMemcardState {
  final List<DetailMemberCard> cards;
  final int cardTotal;

  const GetFeaturedMemcardSuccess(this.cards, this.cardTotal);

  @override
  List<Object?> get props => [cards];
}

class GetMemcardSuccess extends GetFeaturedMemcardState {
  final List<DetailMemberCard> cards;

  const GetMemcardSuccess(this.cards);

  @override
  List<Object?> get props => [cards];
}

class EmptyMemcard extends GetFeaturedMemcardState {}

class GetFeaturedMemcardFail extends GetFeaturedMemcardState {}
