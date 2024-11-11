part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

// class EventLoadedMax extends EventState {}

class EventLoaded extends EventState {
  final List<EventDataModel> event;
  final RequestFilteredEventModel requestEvent;
  final bool hasReachedMax;

  const EventLoaded({
    required this.event,
    required this.requestEvent,
    required this.hasReachedMax,
  });

  EventLoaded copyWith({
    List<EventDataModel>? event,
    RequestFilteredEventModel? requestEvent,
    bool? hasReachedMax,
  }) {
    return EventLoaded(
      event: event ?? this.event,
      requestEvent: requestEvent ?? this.requestEvent,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [event, hasReachedMax];
}

class EventSubmited extends EventState {
  final EventDataModel event;

  const EventSubmited(this.event);
}

class EventLoadError extends EventState {
  final String message;

  const EventLoadError(this.message);

  @override
  List<Object> get props => [message];
}
