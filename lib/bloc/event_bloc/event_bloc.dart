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
    on<EventFetchData>(
      _onEventFetchData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventFetchApprovedData>(
      _onEventFetchApprovedData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventFetchAllData>(
      _onEventFetchAllData,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EventFetchDataByProposeOrAdminUserID>(
      _onEventFetchDataByProposeOrAdminUserID,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EventFetchCarousel>(
      _onEventFetchCarousel,
      transformer: throttleDroppable(throttleDuration),
    );
    // on<EventCardPressed>(_onEventCardPressed);
  }

  // void _onEventCardPressed(
  //     EventCardPressed event, Emitter<EventState> emit) async {
  //   emit(EventLoading());
  //   try {
  //     emit(EventSubmited(event.event));
  //   } catch (e) {
  //     emit(EventLoadError("Failed to find events"));
  //   }
  // }
  void _onEventFetchData(EventFetchData event, Emitter<EventState> emit) async {
    final carousel = await eventRepository.getEventsFromAPI(
      requestEvent: event.requestEventCarousel!,
      pathRequest: event.pathRequest,
    );
    await _handleEventFetch<EventApprovedLoaded>(
      event: event,
      emit: emit,
      createState: (newCombinedEvents, hasReachedMax, request) => EventLoaded(
        listEvents: newCombinedEvents,
        listEventsCarousel: carousel.data!,
        hasReachedMax: hasReachedMax,
        requestEvent: request,
        pathRequest: event.pathRequest,
      ),
      pathRequest: event.pathRequest,
      requestEvent: event.requestEvent,
    );
  }

  void _onEventFetchApprovedData(
      EventFetchApprovedData event, Emitter<EventState> emit) async {
    await _handleEventFetch<EventApprovedLoaded>(
      event: event,
      emit: emit,
      createState: (newCombinedEvents, hasReachedMax, request) =>
          EventApprovedLoaded(
        event: newCombinedEvents,
        hasReachedMax: hasReachedMax,
        requestEvent: request,
      ),
      pathRequest: event.pathRequest,
      requestEvent: event.requestEvent,
    );
  }

  void _onEventFetchAllData(
      EventFetchAllData event, Emitter<EventState> emit) async {
    await _handleEventFetch<EventAllLoaded>(
      event: event,
      emit: emit,
      createState: (newCombinedEvents, hasReachedMax, request) =>
          EventAllLoaded(
        event: newCombinedEvents,
        hasReachedMax: hasReachedMax,
        requestEvent: request,
      ),
      pathRequest: event.pathRequest,
      requestEvent: event.requestEvent,
    );
  }

  void _onEventFetchDataByProposeOrAdminUserID(
      EventFetchDataByProposeOrAdminUserID event,
      Emitter<EventState> emit) async {
    await _handleEventFetch<EventDataByProposeOrAdminUserIDLoaded>(
      event: event,
      emit: emit,
      createState: (newCombinedEvents, hasReachedMax, request) =>
          EventDataByProposeOrAdminUserIDLoaded(
        event: newCombinedEvents,
        hasReachedMax: hasReachedMax,
        requestEvent: request,
      ),
      pathRequest: event.pathRequest,
      requestEvent: event.requestEvent,
    );
  }

  void _onEventFetchCarousel(
      EventFetchCarousel event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      // loading ketika halaman baru saja dibuka
      emit(EventLoading());
      // Mengambil data events dari API
      final events = await eventRepository.getEventsFromAPI(
          requestEvent: event.requestEvent, pathRequest: event.pathRequest);
      emit(EventCarouselLoaded(events.data!));
    } catch (_) {
      emit(EventLoadError("Failed to load initial events request"));
    }
  }

  //! Membuat fungsi untuk mengatasi pemanggilan data ke API dan sekaligus mengatasi logika penambahan setiap event baru dimuat
  Future<void> _handleEventFetch<T>({
    required EventEvent event,
    required Emitter<EventState> emit,
    required EventState Function(
            List<EventDataModel>, bool, RequestFilteredEventModel)
        createState,
    required PathRequestEvents pathRequest,
    required RequestFilteredEventModel requestEvent,
  }) async {
    // Mengecek apakah sudah ada data yang terambil sebelumnya
    if (state is T) {
      try {
        final currentState = state as T;
        // Mengecek apakah semua event yang ada di database sudah termuat
        if ((currentState as dynamic).hasReachedMax) {
          debugPrint("Max Loaded");
          return;
        }
        // Mengambil jumah index yang termuat saat ini
        final currentIndex = (currentState.event.length).toString();
        // Mengambil data event baru berdasarkan index yang termuat saat ini dari API
        final newEvents = await eventRepository.getEventsFromAPI(
          requestEvent: requestEvent.copyWith(currentIndex: currentIndex),
          pathRequest: pathRequest,
        );
        // Menggabungkan data event yang sudah dengan event baru
        final combinedEvents = currentState.event + newEvents.data!;
        // Menentukan apakah data event di DB sudah termuat semua atau belum
        if (newEvents.data!.isEmpty || newEvents.data!.length < 4) {
          emit(createState(combinedEvents, true, requestEvent));
        } else {
          emit(createState(combinedEvents, false, requestEvent));
        }
      } catch (_) {
        emit(EventLoadError("Faied tp load events"));
      }
    }
    // Mengambil data untuk pertama kalinya
    else {
      try {
        // loading ketika halaman baru saja dibuka
        emit(EventLoading());
        // Mengambil data events dari API
        final events = await eventRepository.getEventsFromAPI(
            requestEvent: requestEvent, pathRequest: pathRequest);
        // Menentukan apakah data event di DB sudah termuat semua atau belum
        if (events.data!.length < 4) {
          emit(createState(events.data!, true, requestEvent));
        } else {
          emit(createState(events.data!, false, requestEvent));
        }
      } catch (_) {
        emit(EventLoadError("Failed to load initial events request"));
      }
    }
  }
}
