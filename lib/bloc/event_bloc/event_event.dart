part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventFetchData extends EventEvent {
  // final RequestFilteredEventModel request;

  // const EventFetchData({required this.request});

  // @override
  // List<Object> get props => [request];
}

class EventCardPressed extends EventEvent {
  final List<EventModel> event;

  const EventCardPressed(this.event);

  @override
  List<Object> get props => [event];
}
