import 'dart:async';
import 'package:evently_app/data/events_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/constants/categories_list.dart';
import '../core/models/event_model.dart';

class EventProvider extends ChangeNotifier {
  final EventsRepo _eventsRepo = EventsRepo();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedCategoryId = CategoriesList.categories[1].id;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String searchQuery = "";
  bool _isLoading = false;

  List<EventModel> allEvents = [];
  List<String> favoriteEventIds = [];
  List<EventModel> searchFavResult = [];

  StreamSubscription<List<EventModel>>? _eventsSubscription;
  StreamSubscription<List<String>>? _favsSubscription;
  StreamSubscription<User?>? _authSubscription;

  EventProvider() {
    _syncEvents();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _syncFavorites();
      } else {
        _favsSubscription?.cancel();
        favoriteEventIds = [];
        notifyListeners();
      }
    });
  }

  void _syncEvents() {
    _eventsSubscription?.cancel();
    _eventsSubscription = _eventsRepo.getEventsStream().listen((events) {
      allEvents = events;
      notifyListeners();
    });
  }

  void _syncFavorites() {
    _favsSubscription?.cancel();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      _favsSubscription =
          _eventsRepo.getFavoriteEventIdsStream(uid).listen((favIds) {
        favoriteEventIds = favIds;
        notifyListeners();
      });
    }
  }

  bool get isLoading => _isLoading;

  void searchFavEvents(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      searchFavResult = favEvents;
    } else {
      searchFavResult = favEvents.where((event) {
        return event.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(String eventId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    bool isCurrentlyFav = favoriteEventIds.contains(eventId);

    try {
      if (isCurrentlyFav) {
        await _eventsRepo.removeFromFavorites(uid, eventId);
      } else {
        final event = allEvents.firstWhere((e) => e.id == eventId);
        await _eventsRepo.addToFavorites(uid, event);
      }
    } catch (e) {
      debugPrint("Error toggling favorite: $e");
    }
  }

  List<EventModel> get favEvents {
    return allEvents
        .where((event) => favoriteEventIds.contains(event.id))
        .toList();
  }

  void selectEventType(String id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }

  void changeTime(TimeOfDay newTime) {
    selectedTime = newTime;
    notifyListeners();
  }

  void resetValues() {
    selectedCategoryId = CategoriesList.categories[1].id;
    selectedDate = null;
    selectedTime = null;
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  Future<void> addEvent(EventModel event) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _eventsRepo.addEvent(event);
    } catch (e) {
      debugPrint("Error in addEvent Provider: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEvent(String eventId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _eventsRepo.deleteEvent(eventId);
    } catch (e) {
      debugPrint("Error in deleteEvent Provider: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<EventModel> getFilteredEvents(String filterId) {
    if (filterId == "all") {
      return allEvents;
    } else {
      return allEvents.where((event) => event.category.id == filterId).toList();
    }
  }

  void loadEventData(EventModel event) {
    titleController.text = event.title;
    descriptionController.text = event.description;
    selectedDate = event.dateTime;
    selectedTime = TimeOfDay.fromDateTime(event.dateTime);
    selectedCategoryId = event.category.id;
    notifyListeners();
  }

  Future<void> updateEvent(String eventId) async {
    int index = allEvents.indexWhere((event) => event.id == eventId);
    if (index != -1 && selectedDate != null && selectedTime != null) {
      _isLoading = true;
      notifyListeners();

      DateTime finalDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      var selectedCategory = CategoriesList.categories.firstWhere(
        (cat) => cat.id == selectedCategoryId,
        orElse: () => CategoriesList.categories[1],
      );

      String? ownerUid = allEvents[index].uid;

      EventModel updatedEvent = EventModel(
        id: eventId,
        uid: ownerUid,
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory,
        dateTime: finalDateTime,
      );

      try {
        await _eventsRepo.updateEvent(updatedEvent);
        resetValues();
      } catch (e) {
        debugPrint("Error in updateEvent Provider: $e");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    _favsSubscription?.cancel();
    _authSubscription?.cancel();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
