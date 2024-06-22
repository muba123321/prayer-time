import 'package:flutter/material.dart';
import 'package:gicc/providers/auth_provider.dart';
import 'package:gicc/screens/qibla.dart';
import 'package:gicc/widgets/addevent_widgets/addeventdialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:gicc/screens/events.dart';
import 'package:gicc/screens/profilescreen.dart';
import 'package:gicc/screens/quran.dart';
import 'package:gicc/screens/prayertime_screen.dart';
import 'package:gicc/widgets/prayertimescreen_widgets/buttom_navigationbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernotifier = Provider.of<AuthProvider>(context);
    return Selector<PrayerTimesProvider, int>(
        selector: (p0, provider) => provider.bottomsheetIndex,
        builder: (context, notifier, __) {
          String appBarTitle;
          switch (notifier) {
            case 0:
              appBarTitle = 'Prayer Times';
              break;
            case 1:
              appBarTitle = 'Qibla';
              break;
            case 2:
              appBarTitle = 'Events';
              break;
            case 3:
              appBarTitle = 'Quran';
              break;
            case 4:
              appBarTitle = 'Profile';
              break;
            default:
              appBarTitle = 'Prayer Times';
              break;
          }

          Widget body;

          switch (notifier) {
            case 1:
              body = const QiblaScreen();
              break;
            case 2:
              body = const EventsScreen();
              break;
            case 3:
              body = const QuranScreen();
              break;
            case 4:
              body = const ProfileScreen();
              break;
            default:
              body = const PrayerTimesScreen();
          }
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16),
                child: Text(
                  "GICC",
                  style: GoogleFonts.anton(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 25),
                ),
              ),
              centerTitle: true,
              title: Text(
                appBarTitle,
                style: GoogleFonts.aBeeZee(color: Colors.white),
              ),
              actions: appBarTitle == 'Events' && usernotifier.user != null
                  ? [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const AddEventDialog(), // Show the AddEventDialog
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                            top: 16,
                          ),
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 4.0,
                                  ),
                                  child: Text(
                                    'Add Event',
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [],
              // titleSpacing: 00.0,
              toolbarHeight: 65.2,
              toolbarOpacity: 0.8,
              elevation: 0.00,
              backgroundColor: const Color(0xFF005015),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(2),
                    bottomLeft: Radius.circular(6)),
              ),
            ),
            backgroundColor: const Color(0xFFFFFFFF),
            body: body,
            bottomNavigationBar: const ButtomNavigationBar(),
          );
        });
  }
}
