part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventFetchData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final RequestFilteredEventModel? requestEventCarousel;
  final PathRequestEvents pathRequest;
  final bool? isReload;

  const EventFetchData(
      {required this.requestEvent,
      this.requestEventCarousel,
      required this.pathRequest,
      this.isReload = false});

  @override
  List<Object> get props => [requestEvent, requestEventCarousel!, pathRequest];
}

// class EventReloadData extends EventEvent {
//   final RequestFilteredEventModel requestEvent;
//   final RequestFilteredEventModel? requestEventCarousel;
//   final PathRequestEvents pathRequest;

//   const EventReloadData({
//     required this.requestEvent,
//     this.requestEventCarousel,
//     required this.pathRequest,
//   });

//   @override
//   List<Object> get props => [requestEvent, requestEventCarousel!, pathRequest];
// }

class EventProposeData extends EventEvent {
  final EventDataModel eventData;
  final String token;

  const EventProposeData({required this.eventData, required this.token});

  @override
  List<Object> get props => [eventData, token];
}

class EventUpdateData extends EventEvent {
  final EventDataModel eventData;
  // final String? token;

  const EventUpdateData({
    required this.eventData,
    // required String eventId,
    // this.token,
  });

  @override
  List<Object> get props => [eventData];
}

class EventDeleteData extends EventEvent {
  final String eventID;
  // final String? token;

  const EventDeleteData({
    required this.eventID,
    // this.token,
  });

  @override
  List<Object> get props => [eventID];
}

class EventGetByID extends EventEvent {
  // final String token;
  final String eventId;

  const EventGetByID({
    // required this.token,
    required this.eventId,
  });

  @override
  List<Object> get props => [eventId];
}

// class EventGetByIDRefresh extends EventEvent {
//   // final String token;
//   final String eventId;

//   const EventGetByIDRefresh({
//     // required this.token,
//     required this.eventId,
//   });

//   @override
//   List<Object> get props => [eventId];
// }
