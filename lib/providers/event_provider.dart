import 'package:flutter/material.dart';
import '../core/constants/categories_list.dart';
import '../core/models/event_model.dart';

class EventProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedCategoryId = CategoriesList.categories[1].id;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isFavourite = false;
  String searchQuery = "";

  List<EventModel> allEvents = [];
  List<EventModel> searchFavResult = [];

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

  void toggleFavorite(String eventId) {
    int index = allEvents.indexWhere((event) => event.id == eventId);
    if (index != -1) {
      allEvents[index].isFavorite = !allEvents[index].isFavorite;
      notifyListeners();
    }
  }

  List<EventModel> get favEvents {
    return allEvents.where((event) => event.isFavorite).toList();
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

  void addEvent(EventModel event) {
    allEvents.add(event);
    notifyListeners();
  }

  void deleteEvent(String eventId) {
    allEvents.removeWhere((event) => event.id == eventId);
    notifyListeners();
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

  void updateEvent(String eventId) {
    int index = allEvents.indexWhere((event) => event.id == eventId);
    if (index != -1 && selectedDate != null && selectedTime != null) {
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
      bool oldIsFavorite = allEvents[index].isFavorite;
      EventModel updatedEvent = EventModel(
        id: eventId,
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory,
        dateTime: finalDateTime,
        isFavorite: oldIsFavorite,
      );
      allEvents[index] = updatedEvent;
      resetValues();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
