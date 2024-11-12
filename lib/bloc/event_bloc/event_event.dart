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

class EventFetchProposedDataByProposeUID extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest = PathRequestEvents.allEvents;

  const EventFetchProposedDataByProposeUID({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent];
}

class EventFetchApprovalDataByAdminUID extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest = PathRequestEvents.allEvents;

  const EventFetchApprovalDataByAdminUID({required this.requestEvent});

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
