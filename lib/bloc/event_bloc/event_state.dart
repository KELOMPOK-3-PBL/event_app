part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

// class EventLoadedMax extends EventState {}

class EventApprovedLoaded extends EventState {
  final List<EventDataModel> event;
  final RequestFilteredEventModel requestEvent;
  final bool hasReachedMax;

  const EventApprovedLoaded({
    required this.event,
    required this.requestEvent,
    required this.hasReachedMax,
  });

  EventApprovedLoaded copyWith({
    List<EventDataModel>? event,
    RequestFilteredEventModel? requestEvent,
    bool? hasReachedMax,
  }) {
    return EventApprovedLoaded(
      event: event ?? this.event,
      requestEvent: requestEvent ?? this.requestEvent,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [event, requestEvent, hasReachedMax];
}

class EventProposedByProposeUIDLoaded extends EventState {
  final List<EventDataModel> event;
  final RequestFilteredEventModel requestEvent;
  final bool hasReachedMax;

  const EventProposedByProposeUIDLoaded({
    required this.event,
    required this.requestEvent,
    required this.hasReachedMax,
  });

  EventProposedByProposeUIDLoaded copyWith({
    List<EventDataModel>? event,
    RequestFilteredEventModel? requestEvent,
    bool? hasReachedMax,
  }) {
    return EventProposedByProposeUIDLoaded(
      event: event ?? this.event,
      requestEvent: requestEvent ?? this.requestEvent,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [event, requestEvent, hasReachedMax];
}

class EventApprovalByAdminUIDLoaded extends EventState {
  final List<EventDataModel> event;
  final RequestFilteredEventModel requestEvent;
  final bool hasReachedMax;

  const EventApprovalByAdminUIDLoaded({
    required this.event,
    required this.requestEvent,
    required this.hasReachedMax,
  });

  EventApprovalByAdminUIDLoaded copyWith({
    List<EventDataModel>? event,
    RequestFilteredEventModel? requestEvent,
    bool? hasReachedMax,
  }) {
    return EventApprovalByAdminUIDLoaded(
      event: event ?? this.event,
      requestEvent: requestEvent ?? this.requestEvent,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [event, requestEvent, hasReachedMax];
}

class EventAllLoaded extends EventState {
  final List<EventDataModel> event;
  final RequestFilteredEventModel requestEvent;
  final bool hasReachedMax;

  const EventAllLoaded({
    required this.event,
    required this.requestEvent,
    required this.hasReachedMax,
  });

  EventAllLoaded copyWith({
    List<EventDataModel>? event,
    RequestFilteredEventModel? requestEvent,
    bool? hasReachedMax,
  }) {
    return EventAllLoaded(
      event: event ?? this.event,
      requestEvent: requestEvent ?? this.requestEvent,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [event, requestEvent, hasReachedMax];
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
