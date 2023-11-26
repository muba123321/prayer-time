// lib/providers/prayer_times_provider.dart

// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:islamic_center_prayer_times/prayer_models.dart';
import 'package:islamic_center_prayer_times/services/prayertime_services.dart';

class PrayerTimesProvider extends ChangeNotifier {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  // List<PrayerTime> _prayerTimes = [];

  // List<PrayerTime> get prayerTimes => _prayerTimes;

  // Future<void> fetchPrayerTimes() async {
  //   final List<DateTime> prayerTimesData =
  //       await _prayerTimesService.fetchPrayerTimes(
  //     city: 'Cincinnati',
  //     country: 'US',
  //     year: 2023,
  //     month: 11,
  //   );
  //   _prayerTimes = _convertToPrayerTimes(prayerTimesData);
  //   print('My prayer time after converting ${prayerTimes.first.name}');
  //   print('My prayer time before converting ${prayerTimesData.first}');
  //   notifyListeners();
  // }

  // List<PrayerTime> _convertToPrayerTimes(List<DateTime> prayerTimesData) {
  //   print('${prayerTimesData.length}');
  //   // You can replace these with the actual prayer names in your language
  //   final List<String> prayerNames = [
  //     'Fajr',
  //     'Sunrise',
  //     'Dhuhr',
  //     'Asr',
  //     'Sunset',
  //     'Maghrib',
  //     'Isha',
  //     'Imsak',
  //     'Midnight',
  //   ];

  //   return List.generate(prayerTimesData.length, (index) {
  //     final String name = prayerNames[index];
  //     final DateTime time = prayerTimesData[index];
  //     return PrayerTime(name: name, time: time);
  //   });
  // }

  bool _beep = false;

  bool get beep => _beep;

  void setBeepBool() {
    _beep = !_beep;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  bool _beep1 = false;

  bool get beep1 => _beep1;

  void setBeep1Bool() {
    _beep1 = !_beep1;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  bool _beep2 = false;

  bool get beep2 => _beep2;

  void setBeep2Bool() {
    _beep2 = !_beep2;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  bool _beep3 = false;

  bool get beep3 => _beep3;

  void setBeep3Bool() {
    _beep3 = !_beep3;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  bool _beep4 = false;

  bool get beep4 => _beep4;

  void setBeep4Bool() {
    _beep4 = !_beep4;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  bool _beep5 = false;
  bool get beep5 => _beep5;

  void setBeep5Bool() {
    _beep5 = !_beep5;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  int _bottomsheetIndex = 0;

  int get bottomsheetIndex => _bottomsheetIndex;

  void selectedBottomSheetIndex(int index) {
    _bottomsheetIndex = index;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  Map<String, dynamic> _prayerTimings = {};

  Map<String, dynamic> get prayerTimings => _prayerTimings;

  static bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchPrayerTimingsByAddress({
    String? date,
    String address = '8092 Plantation Drive West Chester, OH 45069',
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      date ??= DateFormat('dd-MM-yyyy').format(DateTime.now());
      _prayerTimings = await _prayerTimesService.fetchTimingsByAddress(
        date: date,
        address: address,
      );
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching prayer timings: $error');
      _isLoading = false;
      notifyListeners();
    }
  }
}
