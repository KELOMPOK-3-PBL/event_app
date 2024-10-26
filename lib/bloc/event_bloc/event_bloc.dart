import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/repository.dart';
import '../../data/model/model.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc({required this.eventRepository}) : super(EventInitial()) {
    // Trigger fetch event right when the bloc is created
    on<FetchEvent>(_onInitialEvent);
    on<EventCardPressed>(_onEventButtonPressed);
  }

  void _onEventButtonPressed(
      EventCardPressed event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      emit(EventSubmited(await eventRepository.getEventData()));
    } catch (e) {
      emit(EventError("Failed to find events with category $event"));
    }
  }

  void _onInitialEvent(FetchEvent event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final categories = await eventRepository.getEventData();
      emit(EventLoaded(categories));
    } catch (e) {
      emit(EventError("Failed to get categories data"));
    }
  }
}
