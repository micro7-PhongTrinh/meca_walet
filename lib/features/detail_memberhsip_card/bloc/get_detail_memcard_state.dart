part of 'get_detail_memcard_cubit.dart';

abstract class GetDetailMemcardState extends Equatable {
  const GetDetailMemcardState();

  @override
  List<Object?> get props => [];
}

class GetDetailMemcardInitial extends GetDetailMemcardState {}

class GetDetailMemcardLoading extends GetDetailMemcardState {}

class GetDetailMemcardSuccess extends GetDetailMemcardState {
  final DetailMemberCard card;

  const GetDetailMemcardSuccess(this.card);
}

class GetDetailMemcardFail extends GetDetailMemcardState {}