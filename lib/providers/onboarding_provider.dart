import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  final SwiperController swiperController = SwiperController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void selectedIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  @override
  void dispose() {
    super.dispose();
    swiperController.dispose();
  }
}
