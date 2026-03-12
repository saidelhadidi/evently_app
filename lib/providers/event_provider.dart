import 'package:flutter/material.dart';

import '../core/constants/categories_list.dart';
import '../core/models/event_model.dart';

class EventProvider extends ChangeNotifier {
  String selectedCategoryId = "sport";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List<EventModel> allEvents = [];

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

  void clearData() {
    titleController.clear();
    descriptionController.clear();
    selectedDate = null;
    selectedTime = null;
    notifyListeners();
  }

  void addEvent(EventModel event) {
    allEvents.add(event);
    notifyListeners();
  }

  List<EventModel> getFilteredEvents(String filterId) {
    if (filterId == "all") {
      return allEvents;
    } else {
      return allEvents.where((event) => event.category.id == filterId).toList();
    }
  }

  void resetValues() {
    selectedCategoryId = CategoriesList.categories[1].id;
    selectedDate = null;
    selectedTime = null;
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
