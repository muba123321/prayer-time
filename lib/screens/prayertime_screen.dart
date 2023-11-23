import 'package:flutter/material.dart';
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

              print(
                  'This is Fajr time.. ${prayerTimings['data']['timings']['Fajr']}');
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
                        _buildPrayerTimeItem(
                            'Fajr', prayerTimings['data']['timings']['Fajr']),
                        _buildPrayerTimeItem('Sunrise',
                            prayerTimings['data']['timings']['Sunrise']),
                        _buildPrayerTimeItem(
                            'Dhuhr', prayerTimings['data']['timings']['Dhuhr']),
                        _buildPrayerTimeItem(
                            'Asr', prayerTimings['data']['timings']['Asr']),
                        _buildPrayerTimeItem('Maghrib',
                            prayerTimings['data']['timings']['Maghrib']),
                        _buildPrayerTimeItem(
                            'Isha', prayerTimings['data']['timings']['Isha']),
                      ]),
                    ),
                  )
                ],
              );
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
            } else {
              return const Text('Press the button to fetch prayer times.');
            }
          },
        ),
      ],
    );
  }
}

Widget _buildPrayerTimeItem(String name, String time) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 80, top: 16, bottom: 16),
    child: Row(
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
