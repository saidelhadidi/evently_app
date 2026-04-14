import 'package:evently_app/core/models/category_model.dart';
import '../constants/categories_list.dart';

class EventModel {
  String? uid; // Firebase User ID (Owner of the event)
  final String id; // Event unique ID
  final String title;
  final String description;
  final CategoryModel category;
  final DateTime dateTime;
  bool isFavorite;

  EventModel({
    required this.id,
    this.uid,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
    this.isFavorite = false,
  });

  /// [fromFirestore] converts a Map (from Firestore) into an [EventModel] object.
  /// We use the 'categoryId' stored in Firestore to find the full [CategoryModel] 
  /// object from our local [CategoriesList].
  factory EventModel.fromFirestore(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      category: CategoriesList.categories.firstWhere(
        (cat) => cat.id == json['categoryId'],
        orElse: () => CategoriesList.categories[0], // Fallback to first category
      ),
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      isFavorite: false, // Always ignore the value from global Firestore
    );
  }

  /// [toJson] converts an [EventModel] object into a Map so it can be saved in Firestore.
  /// We store 'categoryId' instead of the whole category object to keep the database clean
  /// and avoid redundant data.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'description': description,
      'categoryId': category.id,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }
}
