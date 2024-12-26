import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
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
    on<EventGetByID>(
      _onEventGetByID,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventProposed>(
      _onEventProposed,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventUpdateData>(
      _onEventUpdateData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
  }

  Future<void> _onEventFetchData(
      EventFetchData event, Emitter<EventState> emit) async {
    late List<EventDataModel> carousel = [];
    // Mengecek apakah sudah ada data yang terambil sebelumnya
    if (state is EventsListLoaded) {
      try {
        final currentState = state as EventsListLoaded;
        // Mengecek apakah semua event yang ada di database sudah termuat
        if ((currentState as dynamic).hasReachedMax) {
          // debugPrint("Max Loaded");
          return;
        }
        // debugPrint(event.requestEvent.toString());
        // Mengambil jumah index yang termuat saat ini
        final currentIndex = currentState.event.length;
        // Mengambil data event baru berdasarkan index yang termuat saat ini dari API
        final newEvents = await _eventRepository.getEventsFromAPI(
          requestEvent: event.requestEvent.copyWith(currentIndex: currentIndex),
          pathRequest: event.pathRequest,
        );

        // Menggabungkan data event yang sudah dengan event baru
        final combinedEvents = currentState.event + newEvents.listData!;
        // Menentukan apakah data event di DB sudah termuat semua atau belum
        if (newEvents.listData!.isEmpty ||
            newEvents.listData!.length < event.requestEvent.postLimit!) {
          emit(EventsListLoaded(
              event: combinedEvents,
              listEventsCarousel: currentState.listEventsCarousel ?? [],
              requestEvent: event.requestEvent,
              requestEventCarousel: event.requestEventCarousel,
              hasReachedMax: true));
        } else {
          emit(EventsListLoaded(
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
      // debugPrint("Initial Event");

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
          carousel = carouselModel.listData!;
        }
        // Menentukan apakah data event di DB sudah termuat semua atau belum
        if (events.listData!.length < event.requestEvent.postLimit!) {
          emit(EventsListLoaded(
              event: events.listData!,
              listEventsCarousel: carousel,
              requestEvent: event.requestEvent,
              requestEventCarousel: event.requestEventCarousel,
              hasReachedMax: true));
        } else {
          emit(EventsListLoaded(
              event: events.listData!,
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
        carousel = carouselModel.listData!;
      }
      // Menentukan apakah data event di DB sudah termuat semua atau belum
      if (events.listData!.length < event.requestEvent.postLimit!) {
        emit(EventsListLoaded(
            event: events.listData!,
            listEventsCarousel: carousel,
            requestEvent: event.requestEvent,
            requestEventCarousel: event.requestEventCarousel,
            hasReachedMax: true));
      } else {
        emit(EventsListLoaded(
            event: events.listData!,
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
      if (proposeResponse.status == 'success' && proposeResponse.code == 201) {
        emit(EventLoaded(
            message: proposeResponse.message,
            eventData: proposeResponse.data!));
      } else {
        emit(EventError(
            "Error ${proposeResponse.code}: ${proposeResponse.message}"));
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }

  Future<void> _onEventUpdateData(
      EventUpdateData event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final updateResponse = await _eventRepository.updateEvent(
          event.eventId, event.token, event.eventData);
      if (updateResponse['code'] == 200) {
        emit(EventLoaded(
            message: updateResponse['message'],
            eventData: updateResponse['event_data']));
      } else {
        emit(EventError(updateResponse['message']));
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }

  Future<void> _onEventGetByID(
      EventGetByID event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final eventData = await _eventRepository.getEventByIDFromAPI(
          token: event.token, eventId: event.eventId);
      if (eventData.code == 200) {
        emit(EventLoaded(
            message: eventData.message, eventData: eventData.data!));
      } else {
        emit(EventError("Error ${eventData.code}: ${eventData.message}"));
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }
}
