import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic_center_prayer_times/firebase_options.dart';

import 'package:islamic_center_prayer_times/providers/onboarding_provider.dart';
import 'package:islamic_center_prayer_times/providers/prayertimes_provider.dart';
import 'package:islamic_center_prayer_times/screens/splashscreen.dart';
import 'package:islamic_center_prayer_times/services/localnotifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification;
  tz.initializeTimeZones();
  // Initialize the local notifications plugin
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');
  // const InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String? payload) async {
  //   // Handle notification selection
  // });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrayerTimesProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        // Add other providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prayer Times App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
