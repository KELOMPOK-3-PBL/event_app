import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/provider/provider.dart';
import '../../data/repository/repository.dart';
import '../../data/model/model.dart';
import '../throtle_droppable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final _eventRepository = EventRepository();

  EventBloc() : super(EventInitial()) {
    on<EventFetchData>(
      _onEventFetchData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventReloadData>(
      _onEventReloadData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventProposed>(
      _onEventProposed,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
  }

  Future<void> _onEventFetchData(
      EventFetchData event, Emitter<EventState> emit) async {
    late List<EventDataModel> carousel = [];
    // Mengecek apakah sudah ada data yang terambil sebelumnya
    if (state is EventLoaded) {
      try {
        final currentState = state as EventLoaded;
        // Mengecek apakah semua event yang ada di database sudah termuat
        if ((currentState as dynamic).hasReachedMax) {
          debugPrint("Max Loaded");
          return;
        }
        // Mengambil jumah index yang termuat saat ini
        final currentIndex = currentState.event.length;
        // Mengambil data event baru berdasarkan index yang termuat saat ini dari API
        final newEvents = await _eventRepository.getEventsFromAPI(
          requestEvent: event.requestEvent.copyWith(currentIndex: currentIndex),
          pathRequest: event.pathRequest,
        );
        // Menggabungkan data event yang sudah dengan event baru
        final combinedEvents = currentState.event + newEvents.data!;
        // Menentukan apakah data event di DB sudah termuat semua atau belum
        if (newEvents.data!.isEmpty ||
            newEvents.data!.length < event.requestEvent.postLimit!) {
          emit(EventLoaded(
              event: combinedEvents,
              listEventsCarousel: currentState.listEventsCarousel ?? [],
              requestEvent: event.requestEvent,
              requestEventCarousel: event.requestEventCarousel,
              hasReachedMax: true));
        } else {
          emit(EventLoaded(
              event: combinedEvents,
              listEventsCarousel: currentState.listEventsCarousel ?? [],
              requestEvent: event.requestEvent,
              requestEventCarousel: event.requestEventCarousel,
              hasReachedMax: false));
        }
      } catch (_) {
        emit(EventError("Faied to load events"));
      }
    }
    // Mengambil data untuk pertama kalinya
    else {
      try {
        // loading ketika halaman baru saja dibuka
        emit(EventLoading());
        // Mengambil data events dari API
        final events = await _eventRepository.getEventsFromAPI(
            requestEvent: event.requestEvent, pathRequest: event.pathRequest);
        // try {
        if (event.requestEventCarousel != null) {
          final carouselModel = await _eventRepository.getEventsFromAPI(
            requestEvent: event.requestEventCarousel!,
            pathRequest: event.pathRequest,
          );
          carousel = carouselModel.data!;
        }
        // Menentukan apakah data event di DB sudah termuat semua atau belum
        if (events.data!.length < event.requestEvent.postLimit!) {
          emit(EventLoaded(
              event: events.data!,
              listEventsCarousel: carousel,
              requestEvent: event.requestEvent,
              requestEventCarousel: event.requestEventCarousel,
              hasReachedMax: true));
        } else {
          emit(EventLoaded(
              event: events.data!,
              listEventsCarousel: carousel,
              requestEvent: event.requestEvent,
              requestEventCarousel: event.requestEventCarousel,
              hasReachedMax: false));
        }
      } catch (_) {
        emit(EventError("Failed to load initial events request"));
      }
    }
  }

  Future<void> _onEventReloadData(
      EventReloadData event, Emitter<EventState> emit) async {
    try {
      late List<EventDataModel> carousel = [];

      // loading ketika halaman baru saja dibuka
      emit(EventLoading());
      // Mengambil data events dari API
      final events = await _eventRepository.getEventsFromAPI(
          requestEvent: event.requestEvent, pathRequest: event.pathRequest);
      // try {
      if (event.requestEventCarousel != null) {
        final carouselModel = await _eventRepository.getEventsFromAPI(
          requestEvent: event.requestEventCarousel!,
          pathRequest: event.pathRequest,
        );
        carousel = carouselModel.data!;
      }
      // Menentukan apakah data event di DB sudah termuat semua atau belum
      if (events.data!.length < event.requestEvent.postLimit!) {
        emit(EventLoaded(
            event: events.data!,
            listEventsCarousel: carousel,
            requestEvent: event.requestEvent,
            requestEventCarousel: event.requestEventCarousel,
            hasReachedMax: true));
      } else {
        emit(EventLoaded(
            event: events.data!,
            listEventsCarousel: carousel,
            requestEvent: event.requestEvent,
            requestEventCarousel: event.requestEventCarousel,
            hasReachedMax: false));
      }
    } catch (_) {
      emit(EventError("Failed to load initial events request"));
    }
  }

  Future<void> _onEventProposed(
      EventProposed event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final proposeResponse =
          await _eventRepository.proposeEvent(event.token, event.eventData);
      if (proposeResponse['code'] == 201) {
        emit(EventProposeSuccess(
            message: proposeResponse['message'],
            eventData: proposeResponse['event_data']));
      } else {
        emit(EventError(proposeResponse['message']));
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }
}
