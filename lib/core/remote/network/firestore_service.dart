import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/models/event_model.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserData({
    required String uid,
    required String userName,
    required String email,
    String profilePic = '',
  }) async {
    final Map<String, dynamic> userData = {
      "uid": uid,
      "userName": userName,
      "email": email,
      "profilePic": profilePic,
      "createdAt": FieldValue.serverTimestamp(),
    };
    try {
      await _db.collection("users").doc(uid).set(userData, SetOptions(merge: true));
      debugPrint('✅ User data saved/merged successfully with ID: $uid');
    } catch (e) {
      debugPrint('❌ Error saving user data: $e');
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection("users").doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>);
      } else {
        debugPrint("❌ User document does not exist");
        return null;
      }
    } catch (e) {
      debugPrint("❌ Error fetching user data: $e");
      return null;
    }
  }

  Future<void> updateProfilePic(String uid, String profilePicUrl) async {
    try {
      await _db.collection("users").doc(uid).update({
        "profilePic": profilePicUrl,
      });
      debugPrint('✅ Profile picture updated successfully');
    } catch (e) {
      debugPrint('❌ Error updating profile picture: $e');
    }
  }

  Future<void> deleteUserData(String uid) async {
    try {
      await _db.collection("users").doc(uid).delete();
      debugPrint('✅ User data deleted successfully');
    } catch (e) {
      debugPrint('❌ Error deleting user data: $e');
    }
  }

  Future<void> deleteUserEvents(String uid) async {
    try {
      final querySnapshot =
          await _db.collection("events").where("uid", isEqualTo: uid).get();
      final batch = _db.batch();
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      debugPrint('✅ All user events deleted successfully');
    } catch (e) {
      debugPrint('❌ Error deleting user events: $e');
    }
  }

  Future<void> addEvent(EventModel newEvent) async {
    try {
      await _db.collection("events").doc(newEvent.id).set(newEvent.toJson());
      debugPrint('✅ Event Added successfully : ${newEvent.id}');
    } catch (error) {
      debugPrint('❌ Error to add event with id: ${newEvent.id}');
    }
  }

  Future<void> updateEvent(EventModel event) async {
    try {
      await _db
          .collection("events")
          .doc(event.id)
          .set(event.toJson(), SetOptions(merge: true));
      debugPrint('✅ Event Updated successfully : ${event.id}');
    } catch (error) {
      debugPrint('❌ Error updating event with id: ${event.id}: $error');
      rethrow;
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _db.collection("events").doc(eventId).delete();
      debugPrint('✅ Event Deleted successfully : $eventId');
    } catch (error) {
      debugPrint('❌ Error deleting event with id: $eventId: $error');
    }
  }

  Future<void> addToFavorites(String uid, EventModel event) async {
    try {
      await _db
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .doc(event.id)
          .set(event.toJson());
      debugPrint('✅ Event added to favorites: ${event.id}');
    } catch (e) {
      debugPrint('❌ Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String uid, String eventId) async {
    try {
      await _db
          .collection("users")
          .doc(uid)
          .collection("favorites")
          .doc(eventId)
          .delete();
      debugPrint('✅ Event removed from favorites: $eventId');
    } catch (e) {
      debugPrint('❌ Error removing from favorites: $e');
    }
  }

  Stream<List<String>> getFavoriteEventIdsStream(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("favorites")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  /// Fetches all events from the "events" collection in real-time.
  Stream<List<EventModel>> getEventsStream() {
    return _db.collection("events").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromFirestore(doc.data()))
          .toList();
    });
  }

  /// Fetches all events once from the "events" collection.
  Future<List<EventModel>> getAllEvents() async {
    try {
      final querySnapshot = await _db.collection("events").get();
      return querySnapshot.docs
          .map((doc) => EventModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      debugPrint("❌ Error fetching events: $e");
      return [];
    }
  }


}
