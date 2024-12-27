part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventUpdated extends EventState {
  final String message;

  const EventUpdated({required this.message});
}

class EventsListLoaded extends EventState {
  final List<EventDataModel> event;
  final List<EventDataModel>? listEventsCarousel;
  final RequestFilteredEventModel requestEvent;
  final RequestFilteredEventModel? requestEventCarousel;
  // final PathRequestEvents? pathRequest;
  final bool hasReachedMax;

  const EventsListLoaded({
    required this.event,
    this.listEventsCarousel,
    // required this.pathRequest,
    required this.requestEvent,
    this.requestEventCarousel,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [event, requestEvent, hasReachedMax];
}

class EventLoaded extends EventState {
  final EventDataModel eventData;
  final String message;

  const EventLoaded({required this.message, required this.eventData});
}

class EventDeleted extends EventState {
  final String message;

  const EventDeleted({required this.message});
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object> get props => [message];
}
