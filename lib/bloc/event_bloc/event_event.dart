part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventFetchApprovedData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  // final PathRequestEvents pathRequest;
  final PathRequestEvents pathRequest = PathRequestEvents.approvedEvents;

  const EventFetchApprovedData({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent, pathRequest];
}

class EventFetchAllData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest = PathRequestEvents.allEvents;

  const EventFetchAllData({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent, pathRequest];
}

class EventFetchDataByProposeOrAdminUserID extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest = PathRequestEvents.allEvents;

  const EventFetchDataByProposeOrAdminUserID({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent];
}

// class EventFilterApply extends EventEvent {}

class EventCardPressed extends EventEvent {
  final EventDataModel event;

  const EventCardPressed(this.event);

  @override
  List<Object> get props => [event];
}
