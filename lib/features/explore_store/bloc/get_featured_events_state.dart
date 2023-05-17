part of 'get_featured_events_cubit.dart';

abstract class GetFeaturedEventsState extends Equatable {
  const GetFeaturedEventsState();
  

  @override
  List<Object?> get props => [];
}

class GetFeaturedEventsInitial extends GetFeaturedEventsState {}

class GetFeaturedEventsLoading extends GetFeaturedEventsState {}

class GetFeaturedEventsSuccess extends GetFeaturedEventsState {
  final List<EventModel> events;

  const GetFeaturedEventsSuccess(this.events);

  @override
  List<Object?> get props => [events];
}

class GetFeaturedEventsFail extends GetFeaturedEventsState {}
