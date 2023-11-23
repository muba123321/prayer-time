import 'package:flutter/material.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
    return Container(
      // appBar: AppBar(
      //   title: const Text('Prayer Times'),
      // ),
      child: Center(
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
    );
  }
}
