import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/provider/provider.dart';
import '../../data/repository/repository.dart';
import '../../data/model/model.dart';
import '../auth_bloc/auth_bloc.dart';
import '../throtle_droppable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final _eventRepository = EventRepository();
  final AuthBloc authBloc;

  EventBloc({required this.authBloc}) : super(EventInitial()) {
    on<EventFetchData>(
      _onEventFetchData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventGetByID>(
      _onEventGetByID,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventProposeData>(
      _onEventProposed,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventUpdateData>(
      _onEventUpdateData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
    on<EventDeleteData>(
      _onEventDeleteData,
      transformer: throttleDroppable(throttleDuration), // Mengaktifkan throttle
    );
  }

  Future<void> _onEventFetchData(
      EventFetchData event, Emitter<EventState> emit) async {
    late List<EventDataModel> carousel = [];
    // Mengecek apakah sudah ada data yang terambil sebelumnya
    if (state is EventsListLoaded && event.isReload == false) {
      try {
        final currentState = state as EventsListLoaded;
        // Mengecek apakah semua event yang ada di database sudah termuat
        if ((currentState as dynamic).hasReachedMax) {
          // debugPrint("Max Loaded");
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
          debugPrint(carouselModel.toString());
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

  Future<void> _onEventProposed(
      EventProposeData event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final proposeResponse =
          await _eventRepository.proposeEvent(event.token, event.eventData);
      debugPrint(proposeResponse.toString());

      if (proposeResponse['status'] == 'success') {
        emit(EventProposed(
            message: proposeResponse['message'],
            eventId: proposeResponse['event_id']));
      } else {
        emit(EventError(
            "Error ${proposeResponse['code']}: ${proposeResponse['message']}"));
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }

  Future<void> _onEventUpdateData(
      EventUpdateData event, Emitter<EventState> emit) async {
    emit(EventLoading());
    try {
      final authState = authBloc.state;
      if (authState is AuthAuthenticated) {
        final updateResponse = await _eventRepository.updateEvent(
            authState.authData.token!, event.eventData, authState.currentRole!);

        if (updateResponse['status'] == 'success') {
          emit(EventUpdated(message: updateResponse['message']));
        } else {
          emit(EventError(updateResponse['message']));
        }
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }

  Future<void> _onEventGetByID(
      EventGetByID event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final authState = authBloc.state;

    try {
      // debugPrint('load event');

      if (authState is AuthAuthenticated) {
        final eventData = await _eventRepository.getEventByIDFromAPI(
            token: authState.authData.token!, eventId: event.eventId);
        if (eventData.status == 'success') {
          emit(EventLoaded(
              message: eventData.message, eventData: eventData.data!));
        } else {
          emit(EventError("Error ${eventData.code}: ${eventData.message}"));
        }
      } else {
        // debugPrint(' load event failed');
        Exception('Not authentication');
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }

  Future<void> _onEventDeleteData(
      EventDeleteData event, Emitter<EventState> emit) async {
    emit(EventLoading());
    debugPrint('delete event');
    final authState = authBloc.state;

    try {
      if (authState is AuthAuthenticated) {
        final deleteEvent = await _eventRepository.deleteEventFromAPI(
            token: authState.authData.token!, eventId: event.eventID);
        if (deleteEvent['status'] == 'success') {
          emit(EventDeleted(message: deleteEvent['message']));
        } else {
          emit(EventError("Error : ${deleteEvent['message']}"));
        }
      } else {
        Exception('Not authentication');
      }
    } catch (error) {
      emit(EventError(error.toString()));
    }
  }
}
