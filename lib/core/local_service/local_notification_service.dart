// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/constants.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../services/handle_notifications.dart';
import '../../core/local_service/events_local_service.dart';

part 'generated/local_notification_service.g.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationsService {
  final NotificationDetails notificationDetails;
  final EventsLocalService eventsLocalService;
  final HandleNotifications handleNotifications;

  LocalNotificationsService({
    required this.notificationDetails,
    required this.eventsLocalService,
    required this.handleNotifications,
  });

  Future<void> init(BuildContext context) async {
    await _requestPermissions();
    await _initLocalNotifications(context);
    await _initFirebaseMessaging(context);
    await _initOneSignal(context);
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            sound: true,
            alert: true,
            badge: true,
          );
    }
  }

  Future<void> _initLocalNotifications(BuildContext context) async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(requestAlertPermission: true),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        handleLocalNotification(context, response);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> _initFirebaseMessaging(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('FCM Token: $fcmToken');

    FirebaseMessaging.onMessage.listen((message) => _handleFirebaseMessage);
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleFirebaseMessage(context, message));
    FirebaseMessaging.onBackgroundMessage(notificationTapBackgroundFirebase);
  }

  Future<void> _initOneSignal(BuildContext context) async {
    OneSignal.initialize(appIdForOneSignal);
    OneSignal.Notifications.addClickListener((response) async {
      _handleOneSignalNotification(context, response);
    });
  }

  void _handleFirebaseMessage(
    BuildContext context,
    RemoteMessage message,
  ) async {
    final id = message.data['id'];
    final pageName = message.data['pageName'];
    final url = message.data['url'];

    if (id != null) {
      handleNotifications.handleFirebaseMessage(context: context, message: id);
    } else if (pageName != null) {
      handleNotifications.handlePageRoute(context: context, pageName: pageName);
    } else if (url != null) {
      await handleNotifications.handleURL(url: url);
    }
  }

  void _handleOneSignalNotification(BuildContext context, event) async {
    final data = event.notification.additionalData;
    final id = data?['id'];
    final pageName = data?['pageName'];
    final url = data?['url'];

    if (id != null) {
      handleNotifications.handleEvent(context, id);
    } else if (pageName != null) {
      handleNotifications.handlePageRoute(context: context, pageName: pageName);
    } else if (url != null) {
      await handleNotifications.handleURL(url: url);
    }
  }

  Future<bool> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(dateTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        payload: id.toString(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      return true;
    } catch (e, stackTrace) {
      log('Failed to schedule notification', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  //handle all local notification
  Future<void> handleLocalNotification(
      BuildContext context, NotificationResponse response) async {
    if (response.payload != null) {
      handleNotifications.handleEvent(context, response.payload ?? "0");
    } else {
      log("No event ID found in the notification data.");
    }
  }

  Future<void> handleBackgroundNotification(
    BuildContext context,
  ) async {
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      handleLocalNotification(
        context,
        details.notificationResponse!,
      );
    }
  }
}

@pragma('vm:entry-point')
Future<void> notificationTapBackground(NotificationResponse response) async {}

@pragma('vm:entry-point')
Future<void> notificationTapBackgroundFirebase(RemoteMessage message) async {}
@Riverpod(keepAlive: true)
LocalNotificationsService localNotificationsService(Ref ref) {
  final notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      '1',
      'channel',
      channelDescription: 'channel description',
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
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    ),
    iOS: const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    ),
  );

  return LocalNotificationsService(
    notificationDetails: notificationDetails,
    handleNotifications: ref.watch(handleNotificationsProvider),
    eventsLocalService: ref.watch(eventsLocalServiceProvider),
  );
}
