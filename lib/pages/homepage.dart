import 'package:flutter/material.dart';
import 'package:gicc/core/theme/app_text_styles.dart';
import 'package:gicc/providers/auth_provider.dart';
import 'package:gicc/screens/qibla.dart';
import 'package:gicc/widgets/addevent_widgets/addeventdialog.dart';
import 'package:gicc/widgets/navigation/modern_bottom_navigation.dart';
import 'package:gicc/widgets/navigation/quick_action_fab.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:gicc/screens/events.dart';
import 'package:gicc/screens/profilescreen.dart';
import 'package:gicc/screens/quran.dart';
import 'package:gicc/screens/prayertime_screen.dart';
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
              appBarTitle = 'Qibla Direction';
              break;
            case 2:
              appBarTitle = 'Community Events';
              break;
            case 3:
              appBarTitle = 'Quran';
              break;
            case 4:
              appBarTitle = 'Profile';
              break;
            default:
              appBarTitle = 'GICC';
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
                  style: AppTextStyles.withColor(
                    AppTextStyles.headlineSmall,
                    Theme.of(context).appBarTheme.foregroundColor!,
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                appBarTitle,
                style: Theme.of(context).appBarTheme.titleTextStyle,
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
                                  size: 26,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 4.0,
                                  ),
                                  child: Text(
                                    'Add Event',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .foregroundColor,
                                        ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [],
            ),
            body: body,
            floatingActionButton: const QuickActionFab(),
            bottomNavigationBar: const ModernBottomNavigation(),
          );
        });
  }
}
