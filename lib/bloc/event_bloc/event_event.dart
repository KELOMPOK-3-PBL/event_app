part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventFetched extends EventEvent {}

class EventCardPressed extends EventEvent {
  final List<EventModel> event;

  const EventCardPressed(this.event);

  @override
  List<Object> get props => [event];
}
