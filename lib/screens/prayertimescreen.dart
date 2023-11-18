// lib/screens/prayer_times_screen.dart
import 'package:flutter/material.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:islamic_center_prayer_times/widgets/buttom_navigationbar.dart';
import 'package:provider/provider.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (prayerTimesProvider.isLoading)
              const CircularProgressIndicator(),
            if (prayerTimesProvider.prayerTimings.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  prayerTimesProvider.fetchPrayerTimingsByAddress();
                },
                child: const Text('Fetch Prayer Times'),
              ),
            const SizedBox(height: 20),
            Consumer<PrayerTimesProvider>(
              builder: (context, prayerTimesProvider, child) {
                if (prayerTimesProvider.prayerTimings.isNotEmpty) {
                  return Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: prayerTimesProvider.prayerTimings.entries
                          .map((prayerTime) {
                        final String name = prayerTime.key;
                        final dynamic time = prayerTime.value;
                        return Text('$name: $time');
                      }).toList(),
                    ),
                  );
                } else {
                  return const Text('Press the button to fetch prayer times.');
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}
