part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoadedMax extends EventState {}

class EventLoaded extends EventState {
  final List<EventModel> event;
  final bool hasReachedMax;

  const EventLoaded({
    required this.event,
    required this.hasReachedMax,
  });

  EventLoaded copyWith({
    List<EventModel>? event,
    bool? hasReachedMax,
  }) {
    return EventLoaded(
      event: event ?? this.event,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [event, hasReachedMax];
}

class EventSubmited extends EventState {}

class EventLoadError extends EventState {
  final String message;

  const EventLoadError(this.message);

  @override
  List<Object> get props => [message];
}
