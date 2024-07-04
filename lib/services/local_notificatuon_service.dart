import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  static Future<void> init() async {
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

  static Future<void> showNotification() async {
    //android uchun yuboriladigan habarni sozlash
    const androidNotification = AndroidNotificationDetails(
      "Sovgalar ID",
      "Sovgalar kanali",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
    );
  }
}
