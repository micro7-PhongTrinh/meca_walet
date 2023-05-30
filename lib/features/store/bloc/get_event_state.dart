part of 'get_event_cubit.dart';

abstract class GetEventState extends Equatable {
  const GetEventState();

  @override
  List<Object?> get props => [];
}

class GetEventInitial extends GetEventState {}

class GetEventLoading extends GetEventState {}

class GetEventSuccess extends GetEventState {
  final List<Event> events;

  const GetEventSuccess(this.events);
}

class GetEventFail extends GetEventState {}
