part of '../repository.dart';

const _postLimit = 5;

class EventRepository {
  DateTime now = DateTime.now();
  Future<List<EventModel>> getEventData({required int startIndex}) async {
    final response =
        await fetchPosts(startIndex: startIndex, limit: _postLimit);
    return response;
  }

  // Simulasi data API atau database lokal
  Future<List<EventModel>> fetchPosts(
      {required int startIndex, required int limit}) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Data contoh (biasanya ini diambil dari API atau database)
    final List<EventModel> allEvents = [
      EventModel(
        tittle: 'Techcom Fest 2027',
        category: 'Competition',
        quota: '12',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT II",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Proposed",
      ),
      EventModel(
        tittle: 'AI For Technology ',
        category: 'Seminar',
        quota: '120',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Pending",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Approved",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Approved",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Pending",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Pending",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
      EventModel(
        tittle: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://ibb.co.com/C7Dgk1w",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
      ),
    ];

    // Mengambil data sesuai dengan `startIndex` dan `limit`
    final endIndex = (startIndex + limit) > allEvents.length
        ? allEvents.length
        : (startIndex + limit);

    // Mengembalikan subset data dari `allEvents`
    return allEvents.sublist(startIndex, endIndex);
  }
}
