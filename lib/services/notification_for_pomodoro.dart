import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzl;

class NotificationForPomodoro {
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  NotificationForPomodoro() {
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

    await _localNotification.zonedSchedule(
      0,
      'Pomodoro Reminder',
      'Dam olgin bolam',
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
