part of '../repository.dart';

class EventRepository {
  final eventProvider = EventProvider();

  Future<EventModel> getEventDataFromAPI(
      RequestFilteredEventModel requestEvent) async {
    try {
      final response = await eventProvider.getFilteredEvents(requestEvent);

      final data = response.data;

      if (response.statusCode == 200 && data["status"] == 'success') {
        return EventModel.fromJson(json: data);
        // } else if (response.statusCode == 404 || data["status"] == 'error') {
        //   return EventModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API REQUEST FAILED');
    }
  }

  //! repo data statis
  DateTime now = DateTime.now();
  final _postLimit = 5;
  Future<List<EventDataModel>> getEventData({required int startIndex}) async {
    final response =
        await fetchPosts(startIndex: startIndex, limit: _postLimit);
    return response;
  }

  // Simulasi data API atau database lokal
  Future<List<EventDataModel>> fetchPosts(
      {required int startIndex, required int limit}) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Data contoh (biasanya ini diambil dari API atau database)
    final List<EventDataModel> allEvents = [
      EventDataModel(
        title: 'Techcom Fest 2027',
        category: 'Competition',
        quota: '12',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT II",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Proposed",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'AI For Technology ',
        category: 'Seminar',
        quota: '120',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Pending",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Approved",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Approved",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Pending",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Pending",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
      ),
      EventDataModel(
        title: 'Electro Fest',
        category: 'Expo',
        quota: '100',
        posterUrl: "https://i.ibb.co.com/6X9CvTT/Dicding-SYK.jpg",
        place: "GKT I",
        location: "Semarang, Indonesia",
        dateStart: DateFormat('E, d MMM yyy').format(now),
        status: "Rejected",
        eventId: '',
        dateAdd: '',
        proposeUsername: '',
        description: '',
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
