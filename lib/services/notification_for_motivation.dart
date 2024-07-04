import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frp/models/controllers/motivation_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzl;

class NotificationForMotivation {
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();
  final motivationController = MotivationController();
  NotificationForMotivation() {
    tzl.initializeTimeZones();
  }
  static bool timer = false;

  Future<void> schedulePomodoroReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'pomodoro_channel',
      'Pomodoro Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    final List motivation = await motivationController.fetchMotivation();

    await _localNotification.zonedSchedule(
      0,
      'Motivation',
      motivation[0],
      _nextInstanceOfTwoHours(),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTwoHours() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = now.add(const Duration(seconds: 5));
    return scheduledDate;
  }

  Future<void> repeatPomodoroReminder() async {
    await schedulePomodoroReminder();
    Future.delayed(
        const Duration(seconds: 5), timer ? repeatPomodoroReminder : null);
  }

  cancel() {
    timer = false;
    _localNotification.cancelAll();
  }

  void restart() {
    if (!timer) {
      timer = true;
      repeatPomodoroReminder();
    }
  }
}
