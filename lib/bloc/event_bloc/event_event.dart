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
  final PathRequestEvents pathRequest = PathRequestEvents.events;

  const EventFetchAllData({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent, pathRequest];
}

class EventFetchDataByProposeOrAdminUserID extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest = PathRequestEvents.events;

  const EventFetchDataByProposeOrAdminUserID({required this.requestEvent});

  @override
  List<Object> get props => [requestEvent];
}

class EventFetchCarousel extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final PathRequestEvents pathRequest;

  const EventFetchCarousel(
      {required this.requestEvent, required this.pathRequest});

  @override
  List<Object> get props => [requestEvent];
}
// class EventFilterApply extends EventEvent {}

class EventFetchData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final RequestFilteredEventModel? requestEventCarousel;
  final PathRequestEvents pathRequest;

  const EventFetchData(
      {required this.requestEvent,
      this.requestEventCarousel,
      required this.pathRequest});

  EventFetchData copyWith({
    RequestFilteredEventModel? requestEvent,
  }) {
    return EventFetchData(
      requestEvent: requestEvent ?? this.requestEvent,
      // requestEventCarousel: requestEventCarousel,
      pathRequest: pathRequest,
    );
  }

  // @override
  // List<Object> get props => [requestEvent, requestEventCarousel!, pathRequest];
}

// class EventCardPressed extends EventEvent {
//   final EventDataModel event;

//   const EventCardPressed(this.event);

//   @override
//   List<Object> get props => [event];
// }
