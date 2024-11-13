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

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EventBloc extends Bloc<EventEvent, EventState> {
  final eventRepository = EventRepository();

  EventBloc() : super(EventInitial()) {
    on<EventFetchApprovedData>(
      _onEventFetchApprovedData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventFetchAllData>(
      _onEventFetchAllData,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EventFetchApprovalDataByAdminUID>(
      _onEventFetchApprovalDataByAdminUID,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EventFetchProposedDataByProposeUID>(
      _onEventFetchProposedDataByProposeUID,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EventCardPressed>(_onEventCardPressed);
  }

  void _onEventCardPressed(
      EventCardPressed event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      emit(EventSubmited(event.event));
    } catch (e) {
      emit(EventLoadError("Failed to find events"));
    }
  }

  void _onEventFetchApprovedData(
      EventFetchApprovedData event, Emitter<EventState> emit) async {
    if (state is EventApprovedLoaded) {
      try {
        final currentState = state as EventApprovedLoaded;
        if (currentState.hasReachedMax) {
          debugPrint("Max Loaded");
          return;
        }
        //! Mengambil dan menambah dari data statis
        // final newEvents = await eventRepository.getEventData(
        //     startIndex: currentState.event.length);
        //! Mengambil dan menambah data berdasarkan request pada UI ke API
        // Mengganti currentIndex untuk permintaan
        final newEvents = await eventRepository.getEventsFromAPI(
            requestEvent: event.requestEvent
                .copyWith(currentIndex: currentState.event.length.toString()),
            pathRequest: event.pathRequest);
        //! Gabungkan data baru dengan yang sudah ada
        final combinedEvents = currentState.event + newEvents.data!;

        debugPrint("Event baru dikirim: ${combinedEvents.toString()}");
        if (newEvents.data!.length < 4) {
          debugPrint("Jumlah Event baru dikirim: ${newEvents.data!.length}");
          emit(currentState.copyWith(
              event: combinedEvents, hasReachedMax: true));
        } else if (newEvents.data!.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
              event: combinedEvents, hasReachedMax: false));
        }
      } catch (_) {
        emit(EventLoadError("Gagal Load Event"));
      }
    } else {
      // Untuk keadaan EventInitial
      try {
        emit(EventLoading()); //! Loading awal saat memuat event pertama kai
        //! Mengambil data awal dari data statis
        // final events = await eventRepository.getEventData(startIndex: 0);
        //! Mengambil data awal berdasarkan request pada UI ke API
        final EventModel events = await eventRepository.getEventsFromAPI(
            requestEvent: event.requestEvent, pathRequest: event.pathRequest);
        debugPrint("Event dikirim: ${events.toString()}");
        debugPrint("Jumlah Event dikirim: ${events.data!.length}");
        if (events.data!.length < 4) {
          emit(EventApprovedLoaded(
              event: events.data!,
              hasReachedMax: true,
              requestEvent: event.requestEvent));
        } else if (events.data!.isEmpty) {
          emit(EventLoadError("No events data"));
        } else {
          emit(EventApprovedLoaded(
              event: events.data!,
              hasReachedMax: false,
              requestEvent: event.requestEvent));
        }
      } catch (_) {
        emit(EventLoadError("Failed to load initial events"));
      }
    }
  }

  void _onEventFetchAllData(
      EventFetchAllData event, Emitter<EventState> emit) async {
    final request = event.requestEvent;
    debugPrint("Request: ${request.toString()}");
    if (state is EventAllLoaded) {
      try {
        final currentState = state as EventAllLoaded;
        if (currentState.hasReachedMax) {
          debugPrint("Max Loaded");
          return;
        }
        //! Mengambil dan menambah dari data statis
        // final newEvents = await eventRepository.getEventData(
        //     startIndex: currentState.event.length);
        //! Mengambil dan menambah data berdasarkan request pada UI ke API
        // Mengganti currentIndex untuk permintaan
        final currentIndex = currentState.event.length.toString();

        final newEvents = await eventRepository.getEventsFromAPI(
            requestEvent:
                event.requestEvent.copyWith(currentIndex: currentIndex),
            pathRequest: event.pathRequest);
        //! Gabungkan data baru dengan yang sudah ada
        final combinedEvents = currentState.event + newEvents.data!;

        debugPrint("Index Sekarang: ${currentState.event.length.toString()}");
        debugPrint("Event baru dikirim: ${combinedEvents.toString()}");
        if (newEvents.data!.length < 4) {
          debugPrint("Jumlah Event baru dikirim: ${newEvents.data!.length}");
          emit(currentState.copyWith(
              event: combinedEvents, hasReachedMax: true));
        } else if (newEvents.data!.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
              event: combinedEvents,
              hasReachedMax: false,
              requestEvent: event.requestEvent.copyWith(
                  currentIndex: currentState.event.length.toString())));
        }
      } catch (_) {
        emit(EventLoadError("Gagal Load Event"));
      }
    } else {
      // Untuk keadaan EventInitial
      try {
        emit(EventLoading()); //! Loading awal saat memuat event pertama kai
        //! Mengambil data awal dari data statis
        // final events = await eventRepository.getEventData(startIndex: 0);
        //! Mengambil data awal berdasarkan request pada UI ke API
        final EventModel events = await eventRepository.getEventsFromAPI(
            requestEvent: event.requestEvent, pathRequest: event.pathRequest);
        debugPrint("Event dikirim: ${events.toString()}");
        debugPrint("Jumlah Event dikirim: ${events.data!.length}");
        if (events.data!.length < 4) {
          emit(EventAllLoaded(
              event: events.data!,
              hasReachedMax: true,
              requestEvent: event.requestEvent));
        } else if (events.data!.isEmpty) {
          emit(EventLoadError("No events data"));
        } else {
          emit(EventAllLoaded(
              event: events.data!,
              hasReachedMax: false,
              requestEvent: request));
        }
      } catch (_) {
        emit(EventLoadError("Failed to load initial events"));
      }
    }
  }

  void _onEventFetchApprovalDataByAdminUID(
      EventFetchApprovalDataByAdminUID event, Emitter<EventState> emit) async {
    if (state is EventApprovalByAdminUIDLoaded) {
      try {
        final currentState = state as EventApprovalByAdminUIDLoaded;
        if (currentState.hasReachedMax) {
          debugPrint("Max Loaded");
          return;
        }
        //! Mengambil dan menambah dari data statis
        // final newEvents = await eventRepository.getEventData(
        //     startIndex: currentState.event.length);
        //! Mengambil dan menambah data berdasarkan request pada UI ke API
        // Mengganti currentIndex untuk permintaan
        final newEvents = await eventRepository.getEventsFromAPI(
            requestEvent: event.requestEvent
                .copyWith(currentIndex: currentState.event.length.toString()),
            pathRequest: event.pathRequest);
        //! Gabungkan data baru dengan yang sudah ada
        final combinedEvents = currentState.event + newEvents.data!;

        debugPrint("Event baru dikirim: ${newEvents.toString()}");
        if (newEvents.data!.length < 4) {
          debugPrint("Jumlah Event baru dikirim: ${newEvents.data!.length}");
          emit(currentState.copyWith(
              event: combinedEvents, hasReachedMax: true));
        } else if (newEvents.data!.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
              event: combinedEvents, hasReachedMax: false));
        }
      } catch (_) {
        emit(EventLoadError("Gagal Load Event"));
      }
    } else {
      // Untuk keadaan EventInitial
      try {
        emit(EventLoading()); //! Loading awal saat memuat event pertama kai
        //! Mengambil data awal dari data statis
        // final events = await eventRepository.getEventData(startIndex: 0);
        //! Mengambil data awal berdasarkan request pada UI ke API
        final EventModel events = await eventRepository.getEventsFromAPI(
            requestEvent: event.requestEvent, pathRequest: event.pathRequest);
        debugPrint("Event dikirim: ${events.toString()}");
        debugPrint("Jumlah Event dikirim: ${events.data!.length}");
        if (events.data!.length < 4) {
          emit(EventApprovalByAdminUIDLoaded(
              event: events.data!,
              hasReachedMax: true,
              requestEvent: event.requestEvent));
        } else if (events.data!.isEmpty) {
          emit(EventLoadError("No events data"));
        } else {
          emit(EventApprovalByAdminUIDLoaded(
              event: events.data!,
              hasReachedMax: false,
              requestEvent: event.requestEvent));
        }
      } catch (_) {
        emit(EventLoadError("Failed to load initial events"));
      }
    }
  }

  void _onEventFetchProposedDataByProposeUID(
      EventFetchProposedDataByProposeUID event,
      Emitter<EventState> emit) async {}
}
