import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/repository/repository.dart';
import '../../data/model/model.dart';
import '../../bloc/bloc.dart';

part 'event_event.dart';
part 'event_state.dart';

// const _limit = 5;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository eventRepository;
  final AuthBloc authBloc;

  EventBloc({required this.eventRepository, required this.authBloc})
      : super(EventInitial()) {
    on<EventFetched>(
      _onInitialEvent,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventCardPressed>(_onEventButtonPressed);
  }

  void _onEventButtonPressed(
      EventCardPressed event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      emit(EventSubmited());
    } catch (e) {
      emit(EventLoadError("Failed to find events with category $event"));
    }
  }

  void _onInitialEvent(EventFetched event, Emitter<EventState> emit) async {
    if (state is EventLoaded) {
      final currentState = state as EventLoaded;
      // print("state ke-${currentState.event.length}");
      // Jika sudah mencapai batas data, tidak perlu memuat lebih lanjut
      if (currentState.hasReachedMax == true) {
        // emit(EventLoadedMax());
        return;
      }

      try {
        final newEvents = await eventRepository.getEventData(
            startIndex: currentState.event.length);
        // Gabungkan data baru dengan yang sudah ada
        final events = currentState.event + newEvents;

        if (newEvents.length < 4) {
          return emit(
              currentState.copyWith(event: events, hasReachedMax: true));
        }

        emit(currentState.copyWith(event: events, hasReachedMax: false));
      } catch (_) {
        emit(EventLoadError("Gagal Load Event"));
      }
    } else {
      // Untuk keadaan EventInitial
      try {
        emit(EventLoading());
        final events = await eventRepository.getEventData(startIndex: 0);
        emit(EventLoaded(event: events, hasReachedMax: false));
      } catch (_) {
        emit(EventLoadError("Failed to load initial events"));
      }
    }
  }
}
