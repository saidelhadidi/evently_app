import 'package:evently_app/core/models/event_model.dart';
import 'package:evently_app/core/remote/network/firestore_service.dart';

class EventsRepo {
  final FirestoreService _fireStoreService = FirestoreService();

  Stream<List<EventModel>> getEventsStream() {
    return _fireStoreService.getEventsStream();
  }

  Future<void> addEvent(EventModel event) => _fireStoreService.addEvent(event);

  Future<void> deleteEvent(String eventId) =>
      _fireStoreService.deleteEvent(eventId);

  Future<void> updateEvent(EventModel event) =>
      _fireStoreService.updateEvent(event);

  Future<void> addToFavorites(String uid, EventModel event) =>
      _fireStoreService.addToFavorites(uid, event);

  Future<void> removeFromFavorites(String uid, String eventId) =>
      _fireStoreService.removeFromFavorites(uid, eventId);

  Stream<List<String>> getFavoriteEventIdsStream(String uid) =>
      _fireStoreService.getFavoriteEventIdsStream(uid);
}
