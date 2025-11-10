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
              elevation: 0,
              scrolledUnderElevation: 2,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              leading: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2C6B6D),
                        Color(0xFF4A8C8E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.mosque,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              centerTitle: true,
              title: Column(
                children: [
                  Text(
                    appBarTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    'GICC',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280).withValues(alpha: 0.8),
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              actions: appBarTitle == 'Community Events' &&
                      usernotifier.user != null
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const AddEventDialog(),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2C6B6D),
                                    Color(0xFF4A8C8E),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.add_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Add',
                                    style: AppTextStyles.withColor(
                                      AppTextStyles.labelMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
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
