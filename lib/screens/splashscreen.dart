import 'package:flutter/material.dart';
import 'package:islamic_center_prayer_times/screens/onboarding.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:islamic_center_prayer_times/screens/prayertimescreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    prayerTimesProvider =
        Provider.of<PrayerTimesProvider>(context, listen: false);
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboarding') ?? false;
    await prayerTimesProvider.fetchPrayerTimingsByAddress();
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating a splash screen delay
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => onboardingCompleted
              ? const PrayerTimesScreen()
              : const OnboardingScreen(),
        ),
      );
    }
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
