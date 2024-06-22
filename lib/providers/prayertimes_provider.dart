// lib/providers/prayer_times_provider.dart

// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gicc/services/localnotifications.dart';
// import 'package:gicc/prayer_models.dart';
import 'package:gicc/services/prayertime_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';

class PrayerTimesProvider extends ChangeNotifier {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();

// Initialize SharedPreferences instance
  late SharedPreferences _prefs;

  PrayerTimesProvider() {
    _initPrefs();
    loadBeepStatus();
  }

  List<bool> beepstatus = List.generate(8, (index) => false);

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Load beep status from SharedPreferences
  Future<void> loadBeepStatus() async {
    for (int i = 0; i < beepstatus.length; i++) {
      beepstatus[i] = _prefs.getBool('beepstatus_$i') ?? false;
    }
    notifyListeners();
  }

  // Save beep status to SharedPreferences
  Future<void> _saveBeepStatus() async {
    for (int i = 0; i < beepstatus.length; i++) {
      await _prefs.setBool('beepstatus_$i', beepstatus[i]);
    }
  }

  void setBeepBool(int index) {
    beepstatus[index] = !beepstatus[index];
    notifyListeners(); // Notify listeners when the selected index changes
    _saveBeepStatus();
  }

  int _bottomsheetIndex = 0;

  int get bottomsheetIndex => _bottomsheetIndex;

  void selectedBottomSheetIndex(int index) {
    _bottomsheetIndex = index;
    notifyListeners(); // Notify listeners when the selected index changes
  }

  // Map<String, dynamic> _prayerTimings = {};

  // Map<String, dynamic> get prayerTimings => _prayerTimings;

  List<Map<String, dynamic>> _monthlyPrayerTimings = [];

  List<Map<String, dynamic>> get monthlyPrayerTimings => _monthlyPrayerTimings;

  Map<String, String> todayOngoingPrayer = {};

  static bool _isLoading = false;

  bool get isLoading => _isLoading;
  int currentIndex = 0;
  void onIndexChanged(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
  // Future<void> updatePrayerTimesBySwipe(int index) async {
  //   final DateTime selectedDate = DateTime.now().add(Duration(days: index));
  //   await fetchMonthlyPrayerTimingsByAddress(
  //       // date: DateFormat('dd-MM-yyyy').format(selectedDate)
  //       );
  //   log(',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,$selectedDate');
  // }

  // Future<void> fetchPrayerTimingsByAddress({
  //   String? date,
  //   String address = '8092 Plantation Drive West Chester, OH 45069',
  // }) async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();
  //     date ??= DateFormat('dd-MM-yyyy').format(DateTime.now());
  //     _prayerTimings = await _prayerTimesService.fetchTimingsByAddress(
  //       date: date,
  //       address: address,
  //     );
  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error fetching prayer timings: $error');
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchMonthlyPrayerTimingsByAddress(
      {int? year,
      int? month,
      String address = '8092 Plantation Drive West Chester, OH 45069'}) async {
    _isLoading = true;
    notifyListeners();

    try {
      year ??= DateTime.now().year;
      month ??= DateTime.now().month;
      // _monthlyPrayerTimings =
      //     await _prayerTimesService.fetchMonthlyTimingsByAddress(
      //   year: year,
      //   month: month,
      //   address: address,
      // );
      final Map<String, dynamic> response =
          await _prayerTimesService.fetchMonthlyTimingsByAddress(
        year: year,
        month: month,
        address: address,
      );

      if (response.containsKey('data')) {
        _monthlyPrayerTimings =
            List<Map<String, dynamic>>.from(response['data']);
        fetchTodayOngoingPrayer();
        log('Fetched data: $_monthlyPrayerTimings');
        log('Data length: ${_monthlyPrayerTimings.length}');
      } else {
        log('Data key not found in response');
      }
      log('this is it ........$_monthlyPrayerTimings');
      log('this is it the length........${_monthlyPrayerTimings.length}');
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchTodayOngoingPrayer() {
    final now = DateTime.now();
    final todayTimings = _monthlyPrayerTimings.firstWhere(
      (element) =>
          element['date']['gregorian']['date'] ==
          DateFormat('dd-MM-yyyy').format(now),
      orElse: () => {},
    )['timings'];

    if (todayTimings != null) {
      // Create a new map excluding the specific prayers
      final filteredTimings = Map<String, String>.from(todayTimings)
        ..removeWhere((key, value) =>
            key == 'Sunset' ||
            key == 'Midnight' ||
            key == 'Firstthird' ||
            key == 'Lastthird');
      for (final prayer in filteredTimings.entries) {
        final prayerTimeString = prayer.value.replaceAll(RegExp(r'\s*\(.*?\)'),
            ''); // Remove (EDT) or any similar timezone info;
        final prayerTime = DateFormat("HH:mm").parse(prayerTimeString);
        final todayPrayerTime = DateTime(
          now.year,
          now.month,
          now.day,
          prayerTime.hour,
          prayerTime.minute,
        );

        if (todayPrayerTime.isAfter(now)) {
          todayOngoingPrayer = {
            prayer.key: prayer.value.replaceAll(RegExp(r'\s*\(.*?\)'), '')
          };
          log('this is ongoing prayer.......  $todayOngoingPrayer');
          break;
        }
      }
    }

    if (todayOngoingPrayer.isEmpty &&
        todayTimings != null &&
        todayTimings.isNotEmpty) {
      // Create a new map excluding the specific prayers for fallback
      final filteredTimings = Map<String, String>.from(todayTimings)
        ..removeWhere((key, value) =>
            key == 'Sunset' ||
            key == 'Midnight' ||
            key == 'Firstthird' ||
            key == 'Lastthird');
      if (filteredTimings.isNotEmpty) {
        final firstPrayer = filteredTimings.entries.first;
        final prayerTimeString = firstPrayer.value.replaceAll(
            RegExp(r'\s*\(.*?\)'),
            ''); // Remove (EDT) or any similar timezone info
        todayOngoingPrayer = {firstPrayer.key: prayerTimeString};
      }
    }

    notifyListeners();
  }

  // Helper function to schedule notification for a prayer time
  void schedulePrayerTimeNotification(
      String prayerName, String time, int index, bool beep) {
    // Combine date and time strings
    String dateTimeString =
        '${monthlyPrayerTimings[index]['date']['readable']} $time';

    try {
      DateTime parsedDateTime =
          DateFormat('dd MMM yyyy HH:mm').parse(dateTimeString);
      TZDateTime prayerTime = TZDateTime.from(
        parsedDateTime,
        getLocation(
            "America/New_York"), // Assuming you have a function to get the location
      );

      // Schedule notification 5 minutes before the prayer time
      scheduleNotification(
          id: prayerName.hashCode,
          title: 'Prayer Time Reminder',
          body: '5 minutes until $prayerName prayer',
          scheduledDate: prayerTime.subtract(const Duration(minutes: 1)),
          beep: beep);

      // Schedule notification at the prayer time
      scheduleNotification(
          id: prayerName.hashCode + 1,
          title: 'Prayer Time',
          body: 'Is $prayerName prayer time',
          scheduledDate: prayerTime,
          beep: beep);
    } catch (e) {
      // Handle parsing errors, e.g., invalid date or time format
      print('Error parsing date and time: $dateTimeString');
    }
    // Parse the combined string to get TZDateTime
  }

  // Helper function to schedule a single notification
  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
    required bool beep,
  }) {
    // Call your notification service to schedule the notification here
    NotificationService().scheduleNotification(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        beep: beep);
  }

  // Method to get the upcoming prayer time
  Map<String, String> getUpcomingPrayer(int index) {
    final now = DateTime.now();
    final prayerTimings = _monthlyPrayerTimings[index]['timings'];
    Map<String, String> nextPrayer = {};

    for (final prayer in prayerTimings.entries) {
      final prayerTimeString = prayer.value;
      final prayerTime = DateFormat("HH:mm").parse(prayerTimeString);

      final todayPrayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      if (todayPrayerTime.isAfter(now)) {
        nextPrayer = {prayer.key: prayer.value};
        break;
      }
    }

    // If no upcoming prayer found for today, return the first prayer of tomorrow
    if (nextPrayer.isEmpty && prayerTimings.isNotEmpty) {
      final firstPrayer = prayerTimings.entries.first;
      nextPrayer = {firstPrayer.key: firstPrayer.value};
    }

    return nextPrayer;
  }
}
