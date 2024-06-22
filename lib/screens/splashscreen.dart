// import 'package:flutter/material.dart';
// import 'package:islamic_center_prayer_times/screens/onboarding.dart';
// import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
// import 'package:islamic_center_prayer_times/pages/homepage.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {
//   late final PrayerTimesProvider prayerTimesProvider;
//   @override
//   void initState() {
//     super.initState();
//     prayerTimesProvider =
//         Provider.of<PrayerTimesProvider>(context, listen: false);
//     _checkOnboardingStatus();
//   }

//   Future<void> _checkOnboardingStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool onboardingCompleted = prefs.getBool('onboarding') ?? false;

//     await prayerTimesProvider.fetchPrayerTimingsByAddress();
//     await prayerTimesProvider
//         .loadBeepStatus(); // Load beep status before fetching prayer timings
//     await Future.delayed(
//         const Duration(seconds: 2)); // Simulating a splash screen delay
//     if (context.mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               onboardingCompleted ? const HomePage() : const OnboardingScreen(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gicc/screens/onboarding.dart';
import 'package:gicc/providers/prayertimes_provider.dart';
import 'package:gicc/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late final PrayerTimesProvider prayerTimesProvider;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    prayerTimesProvider =
        Provider.of<PrayerTimesProvider>(context, listen: false);
    await _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboarding') ?? false;

    await prayerTimesProvider.fetchMonthlyPrayerTimingsByAddress().then((_) {
      final today = DateTime.now();
      final todayIndex = prayerTimesProvider.monthlyPrayerTimings.indexWhere(
          (element) =>
              element['date']['gregorian']['date'] ==
              DateFormat('dd-MM-yyyy').format(today));

      prayerTimesProvider.currentIndex = todayIndex;
    });
    await prayerTimesProvider
        .loadBeepStatus(); // Load beep status before fetching prayer timings

    await _checkNotificationPermission();
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating a splash screen delay

    if (!mounted) return; // Ensure the context is still mounted

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            onboardingCompleted ? const HomePage() : const OnboardingScreen(),
      ),
    );
  }

  Future<void> _checkNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      await _showNotificationDialog();
    }
  }

  Future<void> _showNotificationDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enable Notifications"),
          content: const Text(
              "This app needs access to notifications to remind you of prayer times. Please enable notifications in the settings."),
          actions: [
            TextButton(
              onPressed: () async {
                await openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text("Open Settings"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
