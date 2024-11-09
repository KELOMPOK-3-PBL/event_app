part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventFetchData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest;

  const EventFetchData({required this.requestEvent, required this.pathRequest});

  @override
  List<Object> get props => [requestEvent];
}

class EventCardPressed extends EventEvent {
  final List<EventModel> event;

  const EventCardPressed(this.event);

  @override
  List<Object> get props => [event];
}
