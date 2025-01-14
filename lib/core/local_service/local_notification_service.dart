import 'dart:async';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
part 'local_notification_service.g.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationsService {
  LocalNotificationsService({
    this.notificationDetails,
  });

  NotificationDetails? notificationDetails;
  // init notifications
  
   Future<void> initNotify() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    try {
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } catch (e) {
      log('Error initializing notifications: $e');
    }
  }

  // show notifications
  Future<void> showNotification({
    required String id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(id),
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      notificationDetails!,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: 'payload',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

@Riverpod(keepAlive: true)
LocalNotificationsService localNotificationsService(Ref ref) {
  final notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      '4',
      'appName Notifications',
      channelDescription: 'This channel is used for saudi calendars',
      category: AndroidNotificationCategory.alarm,
      icon: 'mipmap/ic_launcher',
      importance: Importance.max,
      playSound: true,
      priority: Priority.max,
      showWhen: true,
      ticker: 'ticker',
      enableVibration: true,
      autoCancel: true,
      visibility: NotificationVisibility.public,
    ),
    iOS: const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    ),
  );

  return LocalNotificationsService(
    notificationDetails: notificationDetails,
  );
}

class NotifyItem {
  int? id;
  String? title;
  String? appName;
  tz.TZDateTime? dateTime;
  Map<String, dynamic>? payload;
  DateTimeComponents? repeate;
  bool? isMyEvent;

  NotifyItem({
    this.id,
    this.title,
    this.appName,
    this.dateTime,
    this.payload,
    this.repeate,
    this.isMyEvent,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'appName': appName,
      'dateTime': dateTime,
      'payload': payload,
      'repeate': repeate?.toString(),
      'isMyEvent': isMyEvent,
    };
  }
}
