import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/provider/provider.dart';
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
    on<EventFetchAllData>(
      _onEventFetchData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventCardPressed>(_onEventButtonPressed);
  }

  void _onEventButtonPressed(
      EventCardPressed event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      emit(EventSubmited(event.event));
    } catch (e) {
      emit(EventLoadError("Failed to find events"));
    }
  }

  // void _onEventFetchData(
  //     EventFetchAllData event, Emitter<EventState> emit) async {
  //   try {
  //     // Kondisi jika state adalah EventLoaded, berarti data sudah ada dan ingin ditambahkan
  //     if (state is EventLoaded) {
  //       final currentState = state as EventLoaded;

  //       debugPrint("Index ke-${currentState.event.length}");

  //       // Jika sudah mencapai batas maksimum, keluar dari fungsi tanpa memuat lagi
  //       if (currentState.hasReachedMax) return;

  //       // Memuat data tambahan dari API berdasarkan request dengan currentIndex
  //       final newEvents = await eventRepository.getEventsFromAPI(
  //           requestEvent: event.requestEvent
  //               .copyWith(currentIndex: currentState.event.length.toString()),
  //           pathRequest: event.pathRequest);

  //       // Gabungkan data yang sudah ada dengan data baru jika tidak null
  //       final combinedEvents = currentState.event + (newEvents.data ?? []);

  //       debugPrint("Fetch Event: ${combinedEvents.toString()}");

  //       // Cek apakah data baru kosong atau kurang dari batas (misal 4)
  //       final reachedMax = newEvents.data == null || newEvents.data!.length < 4;
  //       emit(currentState.copyWith(
  //           event: combinedEvents, hasReachedMax: reachedMax));
  //     }
  //     // Kondisi jika state adalah EventInitial, berarti ini pemuatan data awal
  //     else {
  //       emit(EventLoading());

  //       // Memuat data awal dari API
  //       final EventModel initialEvents = await eventRepository.getEventsFromAPI(
  //           requestEvent: event.requestEvent, pathRequest: event.pathRequest);

  //       debugPrint("Initial Event Load: ${initialEvents.toString()}");

  //       // Jika data awal kosong, langsung set hasReachedMax ke true
  //       if (initialEvents.data == null || initialEvents.data!.isEmpty) {
  //         emit(EventLoaded(event: [], hasReachedMax: true));
  //       } else {
  //         emit(EventLoaded(event: initialEvents.data!, hasReachedMax: false));
  //       }
  //     }
  //   } catch (error) {
  //     emit(EventLoadError("Gagal Load Event: ${error.toString()}"));
  //   }
  // }

  void _onEventFetchData(
      EventFetchAllData event, Emitter<EventState> emit) async {
    if (state is EventLoaded) {
      final currentState = state as EventLoaded;
      if (currentState.hasReachedMax == true) {
        return;
      }

      try {
        //! Mengambil dan menambah dari data statis
        final newEvents = await eventRepository.getEventData(
            startIndex: currentState.event.length);
        //! Mengambil dan menambah data berdasarkan request pada UI ke API
        // Mengganti currentIndex untuk permintaan
        // final newEvents = await eventRepository.getEventsFromAPI(
        //     requestEvent: event.requestEvent
        //         .copyWith(currentIndex: currentState.event.length.toString()));
        //! Gabungkan data baru dengan yang sudah ada
        final events = currentState.event + newEvents;

        debugPrint("Fetch Event: ${events.toString()}");
        if (newEvents.isNotEmpty && newEvents.length < 4) {
          debugPrint("Event baru dikirim: ${newEvents.length}");
          // emit(EventLoadedMax());
          emit(currentState.copyWith(event: events, hasReachedMax: true));
          // currentState.copyWith(event: events));
        } else if (newEvents.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          // emit(currentState.copyWith(event: events));
          emit(currentState.copyWith(event: events, hasReachedMax: false));
        }
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
        final events = await eventRepository.getEventData(startIndex: 0);
        //! Mengambil data awal berdasarkan request pada UI ke API
        // final EventModel events = await eventRepository.getEventsFromAPI(
        //     requestEvent: event.requestEvent);
        debugPrint("Event dikirim: ${events.toString()}");

        emit(EventLoaded(event: events, hasReachedMax: false));
      } catch (_) {
        emit(EventLoadError("Failed to load initial events"));
      }
      // } else {
      //   emit(EventLoadError("You don't have access. You Must Login First"));
    }
  }
}
