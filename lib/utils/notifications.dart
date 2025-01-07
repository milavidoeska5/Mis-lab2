import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab2_mis/main.dart';
import 'package:timezone/timezone.dart' as tz;

void scheduleDailyNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'daily_joke',
    'Daily Joke',
    channelDescription: 'Daily reminder for the joke of the day',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Joke of the Day',
    'Check out today’s joke!',
    _nextInstanceOfTime(8, 0),
    notificationDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

void showNotification({required int id, required String title, required String body}) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'instant_notification',
    'Instant Notifications',
    channelDescription: 'Notifications triggered instantly',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    notificationDetails,
  );
}

tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
  tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(Duration(days: 1));
  }
  return scheduledDate;
}
