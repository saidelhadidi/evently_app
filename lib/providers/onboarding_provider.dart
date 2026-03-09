import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController();

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
