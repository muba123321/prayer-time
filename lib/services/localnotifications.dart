import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
//  notificationsPlugin.resolvePlatformSpecificImplementation<
//     AndroidFlutterLocalNotificationsPlugin>().requestNotificationsPermission();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logos');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentSound: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  // notificationDetails() {
  //   return const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channelId',
  //         'channelName',
  //         importance: Importance.max,
  //         enableVibration: true,
  //         playSound: true,
  //         icon: 'logos',
  //       ),
  //       iOS: DarwinNotificationDetails());
  // }

  // Future showNotification(
  //     {int id = 0, String? title, String? body, String? payLoad}) async {
  //   return notificationsPlugin.show(
  //       id, title, body, await notificationDetails());
  // }

  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required TZDateTime scheduledDate,
      required bool beep}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([500, 1000, 500, 2000]),
      playSound: beep,
      icon: 'logos',
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      presentSound: beep,
      //  shouldVibrate: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'custom payload',
    );
  }
}
