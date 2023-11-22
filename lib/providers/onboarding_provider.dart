import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  final SwiperController swiperController = SwiperController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void selectedIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  Future<void> finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding', true);
    // if (context.mounted) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => const PrayerTimesScreen(),
    //     ),
    //   );
    // }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    swiperController.dispose();
    notifyListeners();
  }
}
