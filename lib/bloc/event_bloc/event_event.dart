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

  const EventFetchData({
    required this.requestEvent,
    this.requestEventCarousel,
    required this.pathRequest,
  });

  @override
  List<Object> get props => [requestEvent, requestEventCarousel!, pathRequest];
}

class EventReloadData extends EventEvent {
  final RequestFilteredEventModel requestEvent;
  final RequestFilteredEventModel? requestEventCarousel;
  final PathRequestEvents pathRequest;

  const EventReloadData({
    required this.requestEvent,
    this.requestEventCarousel,
    required this.pathRequest,
  });

  @override
  List<Object> get props => [requestEvent, requestEventCarousel!, pathRequest];
}
