import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:provider/provider.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: const Color(0xFFFDDBDB),
      color: const Color(0xFF772f30),
      iconPadding: 16,
      items: const [
        CurvedNavigationBarItem(
            child: Icon(
              FlutterIslamicIcons.solidKowtow,
              size: 30,
              color: Colors.white,
            ),
            label: 'Prayer Times',
            labelStyle: TextStyle(color: Colors.white)),
        CurvedNavigationBarItem(
            child: Icon(
              FlutterIslamicIcons.solidAllah99,
              size: 30,
              color: Colors.white,
            ),
            label: '99 Names',
            labelStyle: TextStyle(color: Colors.white)),
        CurvedNavigationBarItem(
            child: Icon(
              FlutterIslamicIcons.calendar,
              color: Colors.white,
            ),
            label: 'Calendar',
            labelStyle: TextStyle(color: Colors.white)),
      ],
      onTap: (index) {
        // Handle button tap
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
