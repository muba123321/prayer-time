// lib/screens/prayer_times_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:islamic_center_prayer_times/screens/calendar_screen.dart';
import 'package:islamic_center_prayer_times/screens/names_screen.dart';
import 'package:islamic_center_prayer_times/screens/prayertime_screen.dart';
import 'package:islamic_center_prayer_times/widgets/prayertimescreen_widgets/buttom_navigationbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<PrayerTimesProvider, int>(
        selector: (p0, provider) => provider.bottomsheetIndex,
        builder: (context, notifier, __) {
          String appBarTitle;
          switch (notifier) {
            case 0:
              appBarTitle = 'Prayer Times';
              break;
            case 1:
              appBarTitle = '99 Names of Allah';
              break;
            default:
              appBarTitle = 'Calendar';
              break;
          }

          Widget body;

          switch (notifier) {
            case 1:
              body = const NamesOfAllahScreen();
              break;
            case 2:
              body = const IslamicCalendarScreen();
              break;
            default:
              body = const PrayerTimesScreen();
          }
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              title: Text(
                appBarTitle,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
              // titleSpacing: 00.0,
              toolbarHeight: 60.2,
              toolbarOpacity: 0.8,
              elevation: 0.00,
              backgroundColor: const Color(0xFF772f30),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
            ),
            backgroundColor: const Color(0xFFFDDBDB),
            body: body,
            bottomNavigationBar: const ButtomNavigationBar(),
          );
        });
  }
}
