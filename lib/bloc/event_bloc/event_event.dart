part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventFetchData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest;
  // final PathRequestEvents pathRequest = PathRequestEvents.approvedEvents;

  const EventFetchData({required this.pathRequest, required this.requestEvent});

  @override
  List<Object> get props => [requestEvent, pathRequest];
}

// class EventFetchApprovedData extends EventEvent {
//   final RequestFilteredEventModel requestEvent;
//   final PathRequestEvents pathRequest = PathRequestEvents.approvedEvents;

//   const EventFetchApprovedData({required this.requestEvent});

//   @override
//   List<Object> get props => [requestEvent, pathRequest];
// }

class EventFetchProposedDataByUID extends EventEvent {
  final RequestFilteredEventModel requestEvent;

  const EventFetchProposedDataByUID({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent];
}

class EventFilterApply extends EventEvent {}

class EventCardPressed extends EventEvent {
  final EventDataModel event;

  const EventCardPressed(this.event);

  @override
  List<Object> get props => [event];
}
