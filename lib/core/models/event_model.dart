import 'package:evently_app/core/models/category_model.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final CategoryModel category;
  final DateTime dateTime;
  bool isFavorite;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
    this.isFavorite = false,
  });
}