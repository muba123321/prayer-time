import 'dart:developer';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: context.read<PrayerTimesProvider>().bottomsheetIndex,
      backgroundColor: const Color(0xFFFFFFFF),
      color: const Color(0xFF005015),
      iconPadding: 16,
      animationCurve: Curves.easeOut,
      items: const [
        CurvedNavigationBarItem(
          child: Icon(
            FlutterIslamicIcons.prayingPerson,
            size: 30,
            color: Colors.white,
          ),
          label: 'Prayer Times',
          labelStyle: TextStyle(color: Colors.white),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            FlutterIslamicIcons.qibla,
            size: 30,
            color: Colors.white,
          ),
          label: 'Qibla',
          labelStyle: TextStyle(color: Colors.white),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            FlutterIslamicIcons.community,
            size: 30,
            color: Colors.white,
          ),
          label: 'Events',
          labelStyle: TextStyle(color: Colors.white),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            FlutterIslamicIcons.quran2,
            size: 30,
            color: Colors.white,
          ),
          label: 'Quran',
          labelStyle: TextStyle(color: Colors.white),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            FlutterIslamicIcons.muslim,
            size: 30,
            color: Colors.white,
          ),
          label: 'Profile',
          labelStyle: TextStyle(color: Colors.white),
        ),
      ],
      onTap: (index) {
        // Handle button tap
        log('This is my index $index');
        context.read<PrayerTimesProvider>().selectedBottomSheetIndex(index);
        // switch (index) {

        //   case 0:
        //     selectedBottomSheetIndex(index);
        //     // Navigate to the Prayer Times screen
        //     break;
        //   case 1:
        //     // Navigate to the 99 Names screen
        //     // Navigator.of(context).push(
        //     //   MaterialPageRoute(
        //     //     builder: (context) => const NamesOfAllahScreen(),
        //     //   ),
        //     // );
        //     break;
        //   case 2:
        //     // Navigate to the Calendar screen
        //     break;
        // }
      },
    );
  }
}
