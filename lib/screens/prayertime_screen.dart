import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:islamic_center_prayer_times/services/localnotifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
    final notificationService = NotificationService();
    return
        // appBar: AppBar(
        //   title: const Text('Prayer Times'),
        // ),
        ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (prayerTimesProvider.isLoading)
          const Padding(
            padding: EdgeInsets.only(left: 170.0, right: 170),
            child: SizedBox(child: CircularProgressIndicator()),
          ),
        if (prayerTimesProvider.prayerTimings.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 60.0, right: 60),
            child: ElevatedButton(
              onPressed: () {
                prayerTimesProvider.fetchPrayerTimingsByAddress();
              },
              child: const Text('Fetch Prayer Times'),
            ),
          ),
        const SizedBox(height: 20),
        Consumer<PrayerTimesProvider>(
          builder: (context, prayerTimesProvider, child) {
            if (prayerTimesProvider.prayerTimings.isNotEmpty) {
              final prayerTimings = prayerTimesProvider.prayerTimings;

              // Schedule notification for each prayer time
              _schedulePrayerTimeNotification(
                prayerTimesProvider,
                notificationService,
                'Fajr',
                prayerTimings['data']['timings']['Fajr'],
              );
              _schedulePrayerTimeNotification(
                prayerTimesProvider,
                notificationService,
                'Dhuhr',
                prayerTimings['data']['timings']['Dhuhr'],
              );
              _schedulePrayerTimeNotification(
                prayerTimesProvider,
                notificationService,
                'Asr',
                prayerTimings['data']['timings']['Asr'],
              );
              _schedulePrayerTimeNotification(
                prayerTimesProvider,
                notificationService,
                'Maghrib',
                prayerTimings['data']['timings']['Maghrib'],
              );
              _schedulePrayerTimeNotification(
                prayerTimesProvider,
                notificationService,
                'Isha',
                prayerTimings['data']['timings']['Isha'],
              );
              // ... Schedule notifications for other prayer times
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDateItem(
                            'Date', prayerTimings['data']['date']['readable']),
                        _buildDateItem('Hijri',
                            prayerTimings['data']['date']['hijri']['date']),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFF772f30),
                            width: 2,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(children: [
                        _buildPrayerTimeItem(FlutterIslamicIcons.lantern,
                            'Fajr', prayerTimings['data']['timings']['Fajr']),
                        _buildPrayerTimeItem(
                            Icons.wb_twilight_outlined,
                            'Sunrise',
                            prayerTimings['data']['timings']['Sunrise']),
                        _buildPrayerTimeItem(Icons.wb_sunny_outlined, 'Dhuhr',
                            prayerTimings['data']['timings']['Dhuhr']),
                        _buildPrayerTimeItem(Icons.wb_twilight_outlined, 'Asr',
                            prayerTimings['data']['timings']['Asr']),
                        _buildPrayerTimeItem(
                            FlutterIslamicIcons.crescentMoon,
                            'Maghrib',
                            prayerTimings['data']['timings']['Maghrib']),
                        _buildPrayerTimeItem(FlutterIslamicIcons.mosque, 'Isha',
                            prayerTimings['data']['timings']['Isha']),
                      ]),
                    ),
                  )
                ],
              );
            } else {
              return const Text('Press the button to fetch prayer times.');
            }
          },
        ),
      ],
    );
  }
}

Widget _buildPrayerTimeItem(IconData? icon, String name, String time) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 80, top: 16, bottom: 16),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 14),
        Text(
          '$name:',
          style: GoogleFonts.aBeeZee(
              color: const Color(0xFF772f30),
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        Text(
          time,
          style: GoogleFonts.aBeeZee(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Widget _buildDateItem(String name, String time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        '$name:',
        style: GoogleFonts.aBeeZee(
            color: const Color(0xFF772f30),
            fontSize: 24,
            fontWeight: FontWeight.w700),
      ),
      const SizedBox(width: 10),
      Text(
        time,
        style: GoogleFonts.aBeeZee(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ],
  );
}

// Helper function to schedule notification for a prayer time
void _schedulePrayerTimeNotification(PrayerTimesProvider notifier,
    NotificationService notificationService, String prayerName, String time) {
  // Combine date and time strings
  String dateTimeString =
      '${notifier.prayerTimings['data']['date']['readable']} $time';

  try {
    DateTime parsedDateTime =
        DateFormat('dd MMM yyyy HH:mm').parse(dateTimeString);
    TZDateTime prayerTime = TZDateTime.from(
      parsedDateTime,
      getLocation(notifier.prayerTimings['data']['meta']
          ['timezone']), // Assuming you have a function to get the location
    );

    // Schedule notification 5 minutes before the prayer time
    notificationService.scheduleNotification(
      id: prayerName.hashCode,
      title: 'Prayer Time Reminder',
      body: '5 minutes until $prayerName prayer',
      scheduledDate: prayerTime.subtract(const Duration(minutes: 1)),
    );

    // Schedule notification at the prayer time
    notificationService.scheduleNotification(
      id: prayerName.hashCode + 1,
      title: 'Prayer Time',
      body: 'Is $prayerName prayer time',
      scheduledDate: prayerTime,
    );
  } catch (e) {
    // Handle parsing errors, e.g., invalid date or time format
    print('Error parsing date and time: $dateTimeString');
  }
  // Parse the combined string to get TZDateTime
}




   // Expanded(
              //   child: ListView(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     children: prayerTimesProvider.prayerTimings.entries
              //         .map((prayerTime) {
              //       final String name = prayerTime.key;
              //       final dynamic time = prayerTime.value;
              //       print('This are the names .. $name');
              //       print('This are the times .. $time');
              //       return Text('$name: $time');
              //     }).toList(),
              //   ),
              // );

              // '${notifier.prayerTimings['data']['meta']['latitude']} '