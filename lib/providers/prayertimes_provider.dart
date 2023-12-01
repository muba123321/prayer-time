// lib/providers/prayer_times_provider.dart

// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islamic_center_prayer_times/services/localnotifications.dart';
// import 'package:islamic_center_prayer_times/prayer_models.dart';
import 'package:islamic_center_prayer_times/services/prayertime_services.dart';
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

  // Helper function to schedule notification for a prayer time
  void schedulePrayerTimeNotification(
      String prayerName, String time, bool beep) {
    // Combine date and time strings
    String dateTimeString =
        '${prayerTimings['data']['date']['readable']} $time';

    try {
      DateTime parsedDateTime =
          DateFormat('dd MMM yyyy HH:mm').parse(dateTimeString);
      TZDateTime prayerTime = TZDateTime.from(
        parsedDateTime,
        getLocation(prayerTimings['data']['meta']
            ['timezone']), // Assuming you have a function to get the location
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
}
