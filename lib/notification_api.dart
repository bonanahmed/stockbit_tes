import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final initializationSettings =
        InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        onNotification.add(payload);
      },
    );
  }

  static Future showNotificationSchedule({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    bool? forTomorrow,
    required DateTime scheduleDate,
  }) async =>
      _notifications
          .zonedSchedule(
              id,
              title,
              body,
              tz.TZDateTime.from(scheduleDate, tz.local),
              await notificationDetails(scheduleDate),
              payload: payload,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime)
          .then((value) {
        Get.snackbar("Alarm Has Been Set${forTomorrow! ? " For Tomorrow" : ""}",
            "Your alarm has been set to ${DateFormat("dd/MM/yyyy HH:mm:ss").format(scheduleDate)}");
      });

  static Future notificationDetails(var idDate) async {
    const sound = 'soundalarm.wav';
    return NotificationDetails(
        android: AndroidNotificationDetails(
          "alarm",
          'alarm $idDate',
          channelDescription: 'Alarm set at $idDate',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          visibility: NotificationVisibility.public,
          sound: RawResourceAndroidNotificationSound('soundalarm'),
          enableVibration: true,
        ),
        iOS: IOSNotificationDetails(
          sound: sound,
        ));
  }

  static void cancelAll() => _notifications.cancelAll();
  static void cancel(idDate) => _notifications.cancel(idDate);
}
