import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificatuonService {
  // FlutterLocalNotificationsPlugin classiga xabarnoma sozlamalarini urnatamiz
  static final _localNotofocation = FlutterLocalNotificationsPlugin();

  static bool notificationEnabled = false;
  //Xabarnoomaga ruhsat surash funksiyasi
  static Future<void> requistPermission() async {
    // android uchun ruxsat surash
    if (Platform.isAndroid) {
      final android = _localNotofocation.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      //daxol yuboriladigan xabarlarga  ruxsat bersa true bulmasam false qaytarsin
      notificationEnabled =
          await android?.requestNotificationsPermission() ?? false;

      //rejalashtirib  yuboriladigan xabarlarga  ruxsat bersa true bulmasam false qaytarsin
      notificationEnabled =
          await android?.requestExactAlarmsPermission() ?? false;
    }

    //ios uchun ruxsat noma surash
    else if (Platform.isIOS) {
      //ios uchun xabaranomaga kirish
      final ios = _localNotofocation.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      notificationEnabled = await ios?.requestPermissions(
            sound: true,
            badge: true,
            alert: true,
            // provisional: false,
            // critical: true,
          ) ??
          false;
    }
  }

//xabarnomani sozlash
  static Future<void> init() async {
    final currentTimezone = await FlutterTimezone.getLocalTimezone();
    initializeTimeZones();
    tz.getLocation(currentTimezone);

    const androidSettings = AndroidInitializationSettings("mipmap/ic_launcher");
    const iosSettings = DarwinInitializationSettings();

    //umumiy sozlamalar
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    //flutter local notification plugin ga sozlamalarni yuklash
    await _localNotofocation.initialize(initSettings);
  }

//
  static Future<void> showScheduledNotificationMotivation() async {
    //android uchun yuboriladigan habarni sozlash
    const androidNotification = AndroidNotificationDetails(
      "Sovgalar ID",
      "Sovgalar kanali",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound("notification"),
    );
    const iosNOtification = DarwinNotificationDetails();

    const initNotification = NotificationDetails(
      android: androidNotification,
      iOS: iosNOtification,
    );

    // rejali xabarni kursatish
    await _localNotofocation.zonedSchedule(
      0,
      "Alarm",
      "bolam dam ol endi ",
      tz.TZDateTime.now(tz.local).add(
        const Duration(hours: 24),
      ),
      initNotification,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

//qaytariladigan
  static Future<void> periodicalNotification() async {
    //android uchun yuboriladigan habarni sozlash
    const androidNotification = AndroidNotificationDetails(
      "Sovgalar ID",
      "Sovgalar kanali",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound("notification"),
    );
    const iosNOtification = DarwinNotificationDetails();

    // rejali xabarni kursatish
    await _localNotofocation.periodicallyShowWithDuration(
      1,
      "Alarm",
      "bolam dam ol endi ",
      const Duration(seconds: 5),
      const NotificationDetails(
        android: androidNotification,
        iOS: iosNOtification,
      ),
      payload: "Salom",
    );
  }

  static Future<void> cacelNotification() async {
    _localNotofocation.cancel(1);
  }
}
