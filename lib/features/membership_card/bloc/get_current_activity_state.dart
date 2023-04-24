part of 'get_current_activity_cubit.dart';

abstract class GetCurrentActivityState extends Equatable {
  const GetCurrentActivityState();

  @override
  List<Object?> get props => [];
}

class GetCurrentActivityInitial extends GetCurrentActivityState {}

class GetCurrentActivityLoading extends GetCurrentActivityState {}

class GetCurrentActivitySuccess extends GetCurrentActivityState {
  final List<CardActivityModel> cards;

  const GetCurrentActivitySuccess(this.cards);

  @override
  List<Object?> get props => [cards];
}

class GetCurrentActivityFail extends GetCurrentActivityState {}
