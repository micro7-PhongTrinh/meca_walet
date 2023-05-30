part of 'get_memcard_cubit.dart';

abstract class GetMemcardState extends Equatable {
  const GetMemcardState();

  @override
  List<Object?> get props => [];
}

class GetMemcardInitial extends GetMemcardState {}

class GetMemcardLoading extends GetMemcardState {}

class GetMemcardSuccess extends GetMemcardState {
  final MemberCard card;

  const GetMemcardSuccess(this.card);
}

class GetMemcardFail extends GetMemcardState {}

class NotIntegrateMembership extends GetMemcardState {}
