import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
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
                        // height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFF772f30),
                              width: 2,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: prayerTimings['data']['timings'].length,
                          itemBuilder: (context, index) {
                            final excludedPrayerTimes = [
                              'Sunset',
                              'Midnight',
                              'Firstthird',
                              'Lastthird',
                            ];

                            final prayerTimeKey = prayerTimings['data']
                                    ['timings']
                                .keys
                                .toList()[index];
                            final prayerTimeValue =
                                prayerTimings['data']['timings'][prayerTimeKey];

                            print(prayerTimeKey);
                            print(prayerTimeValue);

                            if (excludedPrayerTimes.contains(prayerTimeKey)) {
                              return const SizedBox
                                  .shrink(); // Skip excluded prayer times
                            }

                            if (!excludedPrayerTimes.contains(prayerTimeKey)) {
                              prayerTimesProvider
                                  .schedulePrayerTimeNotification(
                                prayerTimeKey,
                                prayerTimeValue,
                                prayerTimesProvider.beepstatus[index],
                              );
                            }

                            return _buildPrayerTimeItem(
                                prayerTimesProvider,
                                getPrayerIcon(prayerTimeKey),
                                prayerTimeKey,
                                prayerTimeValue,
                                index,
                                prayerTimesProvider.beepstatus[index],
                                true
                                // notifier.adhanSoundEnabled,
                                );
                          },
                        )),
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

IconData getPrayerIcon(String prayerName) {
  switch (prayerName) {
    case 'Fajr':
      return FlutterIslamicIcons.lantern;
    case 'Sunrise':
      return Icons.wb_twilight_outlined;
    case 'Dhuhr':
      return Icons.wb_sunny_outlined;
    case 'Asr':
      return Icons.wb_twilight_outlined;
    case 'Maghrib':
      return FlutterIslamicIcons.crescentMoon;
    case 'Isha':
      return FlutterIslamicIcons.mosque;
    default:
      return Icons.error_outline;
  }
}

Widget _buildPrayerTimeItem(
  PrayerTimesProvider notifier,
  IconData? icon,
  String name,
  String time,
  int index,
  bool isBeepSoundEnabled,
  bool isAdhanSoundEnabled,
) {
  // Add icons for toggling beep sound and Adhan sound
  final beepIcon =
      isBeepSoundEnabled ? Icons.sensors : Icons.sensors_off_outlined;
  final adhanIcon = isAdhanSoundEnabled
      ? Icons.volume_up_outlined
      : Icons.volume_off_outlined;

  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
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
              color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          width: 30,
        ),
        // Icon for toggling beep sound
        IconButton(
          icon: Icon(
            beepIcon,
            size: 22,
          ),
          onPressed: () {
            notifier.setBeepBool(index);

            print(notifier.beepstatus);
            // Toggle beep sound
            // Implement the logic to toggle the beep sound based on the prayer time
          },
        ),
        // Icon for toggling Adhan sound
        IconButton(
          icon: Icon(
            adhanIcon,
            size: 22,
          ),
          onPressed: () {
            // Toggle Adhan sound
            // Implement the logic to toggle the Adhan sound based on the prayer time
          },
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