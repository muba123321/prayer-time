// import 'package:flutter/material.dart';
// import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
// import 'package:provider/provider.dart';

// class PrayerTimesScreen extends StatelessWidget {
//   const PrayerTimesScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);
//     return
//         // appBar: AppBar(
//         //   title: const Text('Prayer Times'),
//         // ),
//         ListView(
//       // mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         if (prayerTimesProvider.isLoading)
//           const Padding(
//             padding: EdgeInsets.only(left: 170.0, right: 170),
//             child: SizedBox(child: CircularProgressIndicator()),
//           ),
//         if (prayerTimesProvider.prayerTimings.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(top: 16, left: 60.0, right: 60),
//             child: ElevatedButton(
//               onPressed: () {
//                 prayerTimesProvider.fetchPrayerTimingsByAddress();
//               },
//               child: const Text('Fetch Prayer Times'),
//             ),
//           ),
//         const SizedBox(height: 20),
//         Consumer<PrayerTimesProvider>(
//           builder: (context, prayerTimesProvider, child) {
//             if (prayerTimesProvider.prayerTimings.isNotEmpty) {
//               final prayerTimings = prayerTimesProvider.prayerTimings;
//               return Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildDateItem(
//                             'Date', prayerTimings['data']['date']['readable']),
//                         _buildDateItem('Hijri',
//                             prayerTimings['data']['date']['hijri']['date']),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Container(
//                         // height: 200,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: const Color(0xFF772f30),
//                               width: 2,
//                               style: BorderStyle.solid,
//                               strokeAlign: BorderSide.strokeAlignOutside,
//                             ),
//                             borderRadius: BorderRadius.circular(16)),
//                         child: ListView.builder(
//                           padding: const EdgeInsets.all(10),
//                           shrinkWrap: true,
//                           itemCount: prayerTimings['data']['timings'].length,
//                           itemBuilder: (context, index) {
//                             final excludedPrayerTimes = [
//                               'Sunset',
//                               'Midnight',
//                               'Firstthird',
//                               'Lastthird',
//                             ];

//                             final prayerTimeKey = prayerTimings['data']
//                                     ['timings']
//                                 .keys
//                                 .toList()[index];
//                             final prayerTimeValue =
//                                 prayerTimings['data']['timings'][prayerTimeKey];

//                             print(prayerTimeKey);
//                             print(prayerTimeValue);

//                             if (excludedPrayerTimes.contains(prayerTimeKey)) {
//                               return const SizedBox
//                                   .shrink(); // Skip excluded prayer times
//                             }

//                             if (!excludedPrayerTimes.contains(prayerTimeKey)) {
//                               prayerTimesProvider
//                                   .schedulePrayerTimeNotification(
//                                 prayerTimeKey,
//                                 prayerTimeValue,
//                                 prayerTimesProvider.beepstatus[index],
//                               );
//                             }

//                             return _buildPrayerTimeItem(
//                                 prayerTimesProvider,
//                                 getPrayerIcon(prayerTimeKey),
//                                 prayerTimeKey,
//                                 prayerTimeValue,
//                                 index,
//                                 prayerTimesProvider.beepstatus[index],
//                                 true
//                                 // notifier.adhanSoundEnabled,
//                                 );
//                           },
//                         )),
//                   )
//                 ],
//               );
//             } else {
//               return const Text('Press the button to fetch prayer times.');
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// IconData getPrayerIcon(String prayerName) {
//   switch (prayerName) {
//     case 'Fajr':
//       return FlutterIslamicIcons.lantern;
//     case 'Sunrise':
//       return Icons.wb_twilight_outlined;
//     case 'Dhuhr':
//       return Icons.wb_sunny_outlined;
//     case 'Asr':
//       return Icons.wb_twilight_outlined;
//     case 'Maghrib':
//       return FlutterIslamicIcons.crescentMoon;
//     case 'Isha':
//       return FlutterIslamicIcons.mosque;
//     default:
//       return Icons.error_outline;
//   }
// }

// Widget _buildPrayerTimeItem(
//   PrayerTimesProvider notifier,
//   IconData? icon,
//   String name,
//   String time,
//   int index,
//   bool isBeepSoundEnabled,
//   bool isAdhanSoundEnabled,
// ) {
//   // Add icons for toggling beep sound and Adhan sound
//   final beepIcon =
//       isBeepSoundEnabled ? Icons.sensors : Icons.sensors_off_outlined;
//   final adhanIcon = isAdhanSoundEnabled
//       ? Icons.volume_up_outlined
//       : Icons.volume_off_outlined;

//   return Padding(
//     padding: const EdgeInsets.only(top: 10),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(icon),
//         const SizedBox(width: 14),
//         Text(
//           '$name:',
//           style: GoogleFonts.aBeeZee(
//               color: const Color(0xFF772f30),
//               fontSize: 24,
//               fontWeight: FontWeight.w700),
//         ),
//         const Spacer(),
//         Text(
//           time,
//           style: GoogleFonts.aBeeZee(
//               color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(
//           width: 30,
//         ),
//         // Icon for toggling beep sound
//         IconButton(
//           icon: Icon(
//             beepIcon,
//             size: 22,
//           ),
//           onPressed: () {
//             notifier.setBeepBool(index);

//             print(notifier.beepstatus);
//             // Toggle beep sound
//             // Implement the logic to toggle the beep sound based on the prayer time
//           },
//         ),
//         // Icon for toggling Adhan sound
//         IconButton(
//           icon: Icon(
//             adhanIcon,
//             size: 22,
//           ),
//           onPressed: () {
//             // Toggle Adhan sound
//             // Implement the logic to toggle the Adhan sound based on the prayer time
//           },
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildDateItem(String name, String time) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Text(
//         '$name:',
//         style: GoogleFonts.aBeeZee(
//             color: const Color(0xFF772f30),
//             fontSize: 24,
//             fontWeight: FontWeight.w700),
//       ),
//       const SizedBox(width: 10),
//       Text(
//         time,
//         style: GoogleFonts.aBeeZee(
//             color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400),
//       ),
//     ],
//   );
// }

//    // Expanded(
//               //   child: ListView(
//               //     scrollDirection: Axis.vertical,
//               //     shrinkWrap: true,
//               //     children: prayerTimesProvider.prayerTimings.entries
//               //         .map((prayerTime) {
//               //       final String name = prayerTime.key;
//               //       final dynamic time = prayerTime.value;
//               //       print('This are the names .. $name');
//               //       print('This are the times .. $time');
//               //       return Text('$name: $time');
//               //     }).toList(),
//               //   ),
//               // );

//               // '${notifier.prayerTimings['data']['meta']['latitude']} '

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gicc/providers/prayertimes_provider.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  // int _currentIndex = 0;
  // void _onIndexChanged(int newIndex) {
  //   setState(() {
  //     _currentIndex = newIndex;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final prayerTimesProvider = Provider.of<PrayerTimesProvider>(context);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(),
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
                    padding: const EdgeInsets.only(
                        right: 16.0, left: 16, bottom: 16),
                    children: [
                      _buildUpcomingPrayer(prayerTimesProvider,
                          prayerTimesProvider.currentIndex),
                      SizedBox(
                        height: 550, // Set a bounded height for the Swiper
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
                                _buildPrayerTimesList(
                                    prayerTimesProvider, index),
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

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: formattedDate == todayDate
              ? Colors.green.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2, color: const Color(0xFF005015))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateItem('Date', date),
              _buildDateItem('Hijri', hijriDate),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingPrayer(PrayerTimesProvider provider, index) {
    if (provider.todayOngoingPrayer.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if no upcoming prayer
    }

    final prayerName = provider.todayOngoingPrayer.keys.first;
    final prayerTime = provider.todayOngoingPrayer.values.first;

    return Stack(
      children: [
        Image.asset(
          "assets/images/gaskia.png",
          height: 180,
          width: 200,
        ),
        Positioned(
          right: 0,
          bottom: 20,
          child: Container(
            width: 160.7,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black, // Shadow color
                    spreadRadius: 1, // Spread radius
                    // blurRadius: 8, // Blur radius
                    offset: Offset(0, -2), // Offset in x and y directions
                  ),
                ],
                color: const Color(0xFF005015),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Upcoming Prayer',
                    style: GoogleFonts.aBeeZee(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$prayerName - $prayerTime',
                    style: GoogleFonts.aBeeZee(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateItem(String name, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.aBeeZee(
            color: const Color(0xFF005015),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.aBeeZee(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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

      provider.schedulePrayerTimeNotification(
        prayerTimeKey,
        prayerTimeValue,
        index,
        provider.beepstatus[index],
      );

      return _buildPrayerTimeCard(
        provider,
        getPrayerIcon(prayerTimeKey),
        prayerTimeKey,
        prayerTimeValue,
        index,
        provider.beepstatus[index],
      );
    }).toList();
    return Column(
      children: prayerTimeWidgets,
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
    return SizedBox(
      height: 60,
      child: Card(
        // margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(icon, color: const Color(0xFF005015)),
                    const SizedBox(width: 16),
                    Text(
                      name,
                      style: GoogleFonts.aBeeZee(
                        color: const Color(0xFF005015),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.aBeeZee(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                isBeepSoundEnabled
                    ? Icons.notifications
                    : Icons.notifications_off,
                color:
                    isBeepSoundEnabled ? Colors.green : const Color(0xFF005015),
              ),
              onPressed: () {
                provider.setBeepBool(index);
              },
            ),
          ],
        ),
      ),
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
