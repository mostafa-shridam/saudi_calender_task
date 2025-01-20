// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/remote_service/event_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../constants.dart';
import '../../models/event_model.dart';
import '../../services/handle_notifications.dart';
import '../../core/local_service/events_local_service.dart';

part 'generated/local_notification_service.g.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationsService {
  final NotificationDetails notificationDetails;
  final EventsLocalService eventsLocalService;
  final EventRemoteService eventRemoteService;
  final HandleNotifications handleNotifications;

  LocalNotificationsService({
    required this.notificationDetails,
    required this.eventRemoteService,
    required this.handleNotifications,
    required this.eventsLocalService,
  });

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            sound: true,
            alert: true,
            badge: true,
            critical: true,
          );
    }
  }

  Future<void> initNotify(BuildContext context) async {
    await _requestPermissions();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) =>
          handleNotifications.handleEvent(
        context,
        int.tryParse(response.payload ?? ''),
      ),
      onDidReceiveBackgroundNotificationResponse: backgroundHandler,
    );
  }

  Future<void> handleURL({required String url}) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  Future<void> showScheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    if (id.isEmpty) {
      log('Notification id is empty.');
      return;
    }

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(id),
        title,
        body,
        tz.TZDateTime.from(dateTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        payload: id,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e, stackTrace) {
      log('Failed to schedule notification', error: e, stackTrace: stackTrace);
    }
  }

// one signal notifications init
  Future<void> initOneSignal() async {
    OneSignal.initialize(appIdForOneSignal);
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Notifications.lifecycleInit();
    OneSignal.Debug.setAlertLevel(OSLogLevel.verbose);
    OneSignal.Notifications.requestPermission(true);
  }

// one signal notifications
  void oneSignalNotifications({required BuildContext context}) async {
    OneSignal.Notifications.addClickListener((event) async {
      final eventId = event.notification.additionalData?["id"];
      final url = event.notification.additionalData?["url"];
      final pageName = event.notification.additionalData?["pageName"];
      EventModel? events;

      events ??= eventsLocalService.getEvents()?.data?.firstWhereOrNull(
            (e) => e.id == eventId.toString(),
          );
      // check if notification has eventId and filter ids
      if (events != null) {
        handleNotifications.handleEvent(
          context,
          int.tryParse(events.id ?? "0"),
        );
        // check if notification has url
      } else if (url != null) {
        await handleURL(url: url);
        // check if notification has pageName
      } else if (pageName != null) {
        final pageName = event.notification.additionalData?["pageName"];
        if (pageName != null) {
          handleNotifications.handlePageRoute(
            context: context,
            pageName: pageName,
          );
        }
      }
    });
  }

  Future<void> firebaseNotify({
    required BuildContext context,
    required RemoteMessage event,
  }) async {
    // check if notification has pageName
    if (event.data['pageName'] != null) {
      handleFirebaseNotification(
        event,
      );
      handleNotifications.handlePageRoute(
        context: context,
        pageName: event.data['pageName'],
      );
      // check if notification has id
    } else if (event.data['id'] != null) {
      handleFirebaseNotification(
        event,
      );
      handleNotifications.handleFirebaseMessage(
        context: context,
        message: event.data['id'],
      );
      // check if notification has url
    } else if (event.data['url'] != null) {
      await handleURL(url: event.data['url']);
    }
  }

// init firebase notifications
  Future<void> initFirebaseMessaging({
    required BuildContext context,
  }) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('FCM Token: $fcmToken');

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(handleFirebaseNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleFirebaseNotification);
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
  }

  void handleFirebaseNotification(
    RemoteMessage? message,
  ) {
    final notification = message?.notification;
    final android = message?.notification?.android;
    final apple = message?.notification?.apple;
    EventModel? event;

    event ??= eventsLocalService.getEvents()?.data?.firstWhereOrNull(
          (e) => e.id == message?.data['id'],
        );
    if (notification != null && android != null && event != null) {
      flutterLocalNotificationsPlugin.show(
        int.parse(event.id ?? '0'),
        notification.title,
        notification.body,
        notificationDetails,
        payload: message?.data['id'] ?? "0",
      );
    } else if (notification != null && apple != null && event != null) {
      flutterLocalNotificationsPlugin.show(
        int.parse(event.id ?? '0'),
        notification.title,
        notification.body,
        notificationDetails,
        payload: message?.data['id'] ?? "0",
      );
    }
  }
}

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
      color: Colors.red,
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      styleInformation: BigTextStyleInformation(''),
      subText: '',
    ),
    iOS: const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    ),
  );

  return LocalNotificationsService(
    notificationDetails: notificationDetails,
    eventRemoteService: ref.watch(eventRemoteServiceStateProvider),
    handleNotifications: ref.watch(handleNotificationsProvider),
    eventsLocalService: ref.watch(eventsLocalServiceProvider),
  );
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(
    NotificationResponse notificationResponse) async {}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
