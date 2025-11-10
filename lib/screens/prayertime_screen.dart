import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:gicc/widgets/prayer_widgets/modern_prayer_card.dart';
import 'package:gicc/widgets/prayer_widgets/modern_date_card.dart';
import 'package:gicc/widgets/prayer_widgets/upcoming_prayer_widget.dart';
import 'package:gicc/utils/prayer_time_helper.dart';
import 'package:gicc/utils/responsive_utils.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  @override
  Widget build(BuildContext context) {
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
    final responsive = context.responsive;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF5F7FA),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: prayerTimesProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => prayerTimesProvider
                      .fetchMonthlyPrayerTimingsByAddress()
                      .then((_) {
                    final today = DateTime.now();
                    final todayIndex = prayerTimesProvider.monthlyPrayerTimings
                        .indexWhere((element) =>
                            element['date']['gregorian']['date'] ==
                            DateFormat('dd-MM-yyyy').format(today));

                    prayerTimesProvider.currentIndex = todayIndex;
                  }),
                  child: ListView(
                    padding:
                        responsive.paddingSymmetric(horizontal: 4, vertical: 2),
                    children: [
                      _buildUpcomingPrayer(prayerTimesProvider,
                          prayerTimesProvider.currentIndex),
                      SizedBox(
                        height: responsive.hp(65), // Responsive height
                        child: Swiper(
                          itemCount:
                              prayerTimesProvider.monthlyPrayerTimings.length,
                          index: prayerTimesProvider.currentIndex,
                          onIndexChanged: (index) {
                            prayerTimesProvider.onIndexChanged(index);
                            // prayerTimesProvider.updatePrayerTimesBySwipe(index);
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDateInfo(prayerTimesProvider, index),
                                Expanded(
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      _buildPrayerTimesList(
                                          prayerTimesProvider, index),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDateInfo(PrayerTimesProvider provider, index) {
    final date =
        provider.monthlyPrayerTimings[index]['date']['gregorian']['date'];
    final hijriDate =
        provider.monthlyPrayerTimings[index]['date']['hijri']['date'];

    // Parse the dateString to a DateTime object
    final dateParts = date.split('-');
    final dateused = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
    );

    final formattedDate = DateFormat('dd-MM-yyyy').format(dateused);
    final todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return ModernDateCard(
      gregorianDate: date,
      hijriDate: hijriDate,
      isToday: formattedDate == todayDate,
    );
  }

  Widget _buildUpcomingPrayer(PrayerTimesProvider provider, index) {
    if (provider.todayOngoingPrayer.isEmpty) {
      return const SizedBox.shrink();
    }

    final prayerName = provider.todayOngoingPrayer.keys.first;
    final prayerTime = provider.todayOngoingPrayer.values.first;

    // Calculate countdown using helper
    final countdownText = PrayerTimeHelper.calculateCountdown(prayerTime);

    return UpcomingPrayerWidget(
      prayerName: prayerName,
      prayerTime: prayerTime,
      countdown: countdownText,
    );
  }

  Widget _buildPrayerTimesList(PrayerTimesProvider provider, int index) {
    final prayerTimings = provider.monthlyPrayerTimings[index]['timings'];
    final excludedPrayerTimes = [
      'Sunset',
      'Midnight',
      'Firstthird',
      'Lastthird'
    ];

    List<Widget> prayerTimeWidgets = prayerTimings.entries
        .where((entry) => !excludedPrayerTimes.contains(entry.key))
        .map<Widget>((entry) {
      final prayerTimeKey = entry.key;
      final prayerTimeValue = entry.value.replaceAll(RegExp(r'\s*\(.*?\)'), '');
      final index = prayerTimings.keys.toList().indexOf(prayerTimeKey);

      return _buildPrayerTimeCard(
        provider,
        getPrayerIcon(prayerTimeKey),
        prayerTimeKey,
        prayerTimeValue,
        index,
        provider.beepstatus[index],
      );
    }).toList();

    final responsive = context.responsive;
    return Column(
      children: [
        ...prayerTimeWidgets,
        SizedBox(height: responsive.hp(6)), // Add bottom spacing
      ],
    );
  }

  Widget _buildPrayerTimeCard(
    PrayerTimesProvider provider,
    IconData icon,
    String name,
    String time,
    int index,
    bool isBeepSoundEnabled,
  ) {
    // Calculate if this prayer is the current one
    final now = DateTime.now();
    final timeParts = time.split(':');
    bool isCurrent = false;

    if (timeParts.length == 2) {
      try {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);
        final prayerDateTime =
            DateTime(now.year, now.month, now.day, hour, minute);

        // Check if this prayer is within 30 minutes (before or after)
        final difference = prayerDateTime.difference(now).abs();
        isCurrent = difference.inMinutes <= 30;
      } catch (e) {
        isCurrent = false;
      }
    }

    return ModernPrayerCard(
      prayerName: name,
      prayerTime: time,
      isActive: isCurrent,
      isBeepEnabled: isBeepSoundEnabled,
      onToggleBeep: () {
        provider.setBeepBool(index);
      },
    );
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
        return FlutterIslamicIcons.prayer;
    }
  }
}
