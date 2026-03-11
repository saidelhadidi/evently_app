import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  String currentCategoryId = "all";

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void changeCategoryView(String id) {
    currentCategoryId = id;
    notifyListeners();
  }
}
