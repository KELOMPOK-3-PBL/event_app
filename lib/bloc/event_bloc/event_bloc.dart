import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/repository/repository.dart';
import '../../data/model/model.dart';

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
  final eventRepository = EventRepository();

  EventBloc() : super(EventInitial()) {
    on<EventFetchData>(
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

  void _onInitialEvent(EventFetchData event, Emitter<EventState> emit) async {
    if (state is EventLoaded) {
      final currentState = state as EventLoaded;
      if (currentState.hasReachedMax == true) {
        return;
      }

      try {
        //! Mengambil dan menambah dari data statis
        // final newEvents = await eventRepository.getEventData(
        //     startIndex: currentState.event.length);
        //! Mengambil dan menambah data berdasarkan request pada UI ke API
        // Mengganti currentIndex untuk permintaan
        final newEvents = await eventRepository.getEventDataFromAPI(
            requestEvent: event.requestEvent
                .copyWith(currentIndex: currentState.event.length.toString()));
        //! Gabungkan data baru dengan yang sudah ada
        final events = currentState.event + newEvents.data!;

        if (newEvents.data!.isNotEmpty && newEvents.data!.length < 4) {
          debugPrint("Event dikirim: ${newEvents.data!.length}");
          // emit(EventLoadedMax());
          return emit(
              currentState.copyWith(event: events, hasReachedMax: true));
          // currentState.copyWith(event: events));
        }

        // emit(currentState.copyWith(event: events));
        emit(currentState.copyWith(event: events, hasReachedMax: false));
      } catch (_) {
        emit(EventLoadError("Gagal Load Event"));
      }
    } else
    // else if (state is EventInitial)
    {
      // Untuk keadaan EventInitial
      try {
        emit(EventLoading()); //! Loading awal saat memuat event pertama kai
        //! Mengambil data awal dari data statis
        // final events = await eventRepository.getEventData(startIndex: 0);
        //! Mengambil data awal berdasarkan request pada UI ke API
        final events = await eventRepository.getEventDataFromAPI(
            requestEvent: event.requestEvent);
        debugPrint(events.toString());
        emit(EventLoaded(event: events.data!, hasReachedMax: false));
      } catch (e) {
        emit(EventLoadError(e.toString()));
      }
      // } else {
      //   emit(EventLoadError("You don't have access. You Must Login First"));
    }
  }
}
