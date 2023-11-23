// lib/services/prayer_times_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:timezone/data/latest.dart' as tzdata;
// import 'package:timezone/timezone.dart';

class PrayerTimesService {
  static const String apiUrl = 'http://api.aladhan.com/v1/timingsByAddress';

  Future<Map<String, dynamic>> fetchTimingsByAddress({
    required String date,
    required String address,
    int method = 2,
    String shafaq = 'general',
    String tune = '0, 0 , -1, 0, 0, 3, 0, 0, 0,',
    int school = 0,
    int midnightMode = 0,
    int latitudeAdjustmentMethod = 3,
    int adjustment = 0,
    bool iso8601 = false,
  }) async {
    final Uri uri = Uri.parse(
      '$apiUrl/$date?address=$address&method=$method'
      '&shafaq=$shafaq&tune=$tune&school=$school&midnightMode=$midnightMode'
      '&latitudeAdjustmentMethod=$latitudeAdjustmentMethod&adjustment=$adjustment&iso8601=$iso8601',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> prayerTimings = json.decode(response.body);
        return prayerTimings;
      } else {
        throw Exception('Failed to fetch prayer times by address');
      }
    } catch (error) {
      throw Exception(
        'Failed to connect to the API. Check your internet connection. $error',
      );
    }

    // PrayerTimesService() {
    //   tzdata.initializeTimeZones();
    // }
    // static const String apiUrl = 'http://api.aladhan.com/v1/calendarByCity';

    // Future<List<DateTime>> fetchPrayerTimes({
    //   required String city,
    //   required String country,
    //   required int year,
    //   required int month,
    //   int method = 2, // Default method
    //   String shafaq = 'general', // Default shafaq
    //   String tune = '',
    //   int school = 0, // Default school
    //   int midnightMode = 0, // Default midnightMode
    //   int latitudeAdjustmentMethod = 3, // Default latitudeAdjustmentMethod
    //   int adjustment = 0,
    //   bool iso8601 = false,
    // }) async {
    //   final Uri uri = Uri.parse(
    //       '$apiUrl/$year/$month?city=$city&country=$country&method=$method'
    //       '&shafaq=$shafaq&tune=$tune&school=$school&midnightMode=$midnightMode'
    //       '&latitudeAdjustmentMethod=$latitudeAdjustmentMethod&adjustment=$adjustment&iso8601=$iso8601');

    //   try {
    //     final response = await http.get(uri);

    //     if (response.statusCode == 200) {
    //       final List<DateTime> prayerTimes = _parsePrayerTimes(response.body);
    //       return prayerTimes;
    //     } else {
    //       throw Exception('Failed to fetch prayer times');
    //     }
    //   } catch (error) {
    //     throw Exception(
    //         'Failed to connect to the API. Check your internet connection.$error');
    //   }
    // }

    // List<DateTime> _parsePrayerTimes(String responseBody) {
    //   final Map<String, dynamic> data = json.decode(responseBody);
    //   final List<dynamic> items = data['data'];

    //   final List<DateTime> prayerTimes = [];

    //   for (var item in items) {
    //     final Map<String, dynamic> timings = item['timings'];

    //     DateTime parseDateTime(String time) {
    //       try {
    //         final parsedTime = DateFormat.Hm().parse(time);
    //         final timeZoneAbbreviation =
    //             time.substring(time.lastIndexOf(' ') + 1);
    //         final timeZoneAbbreviationWithoutParentheses =
    //             timeZoneAbbreviation.replaceAll('(', '').replaceAll(')', '');

    //         // Define the time zone mapping based on the abbreviation
    //         final timeZoneMap = {
    //           'EDT':
    //               'America/New_York', // Adjust this based on the actual time zone
    //           'EST':
    //               'America/New_York', // Adjust this based on the actual time zone
    //           // Add more time zones as needed
    //         };

    //         final timeZone = timeZoneMap[timeZoneAbbreviationWithoutParentheses];

    //         if (timeZone != null) {
    //           return TZDateTime.from(parsedTime, getLocation(timeZone));
    //         } else {
    //           print('Unknown time zone: $timeZoneAbbreviation');
    //           return DateTime.now(); // Provide a default value
    //         }
    //       } catch (e) {
    //         print('Error parsing date: $time');
    //         print('Raw Date String: $time');
    //         return DateTime.now(); // Provide a default value
    //       }
    //     }

    //     final DateTime fajr = parseDateTime(timings['Fajr']);
    //     final DateTime sunrise = parseDateTime(timings['Sunrise']);
    //     final DateTime dhuhr = parseDateTime(timings['Dhuhr']);
    //     final DateTime asr = parseDateTime(timings['Asr']);
    //     final DateTime maghrib = parseDateTime(timings['Maghrib']);
    //     final DateTime isha = parseDateTime(timings['Isha']);
    //     final DateTime imsak = parseDateTime(timings['Imsak']);
    //     final DateTime midnight = parseDateTime(timings['Midnight']);

    //     prayerTimes
    //         .addAll([fajr, sunrise, dhuhr, asr, maghrib, isha, imsak, midnight]);
    //   }

    //   return prayerTimes;
    // }
  }
}
