// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/local_service/my_events_local_service.dart';
import 'package:saudi_calender_task/models/my_event.dart';
import 'package:saudi_calender_task/ui/pages/my_event_details/my_event_details.dart';
import '../core/local_service/events_local_service.dart';
import '../providers/event_provider.dart';
import '../ui/pages/details/details_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'generated/handle_notifications.g.dart';

class HandleNotifications {
  final EventsLocalService eventsLocalService;
  final EventRemoteService eventsRemoteService;
  final MyEventsLocalService myEventsLocalService;

  HandleNotifications({
    required this.eventsLocalService,
    required this.eventsRemoteService,
    required this.myEventsLocalService,
  });
  Future<void> handleEvent(BuildContext context, String? eventId) async {
    log("handleEvent eventId: $eventId");

    if (eventId == null) {
      log("No event ID found in the notification data.");
      return;
    }

    final event = eventsLocalService.getEvents()?.data?.firstWhereOrNull(
          (e) => e.id == eventId,
        );

    if (event != null) {
      log("Event In LocalService: ${event.id}");
      context.pushNamed(
        DetailsPage.routeName,
        extra: event,
      );
      return;
    }

    final myEvents = myEventsLocalService.getMyEvents();
    if (myEvents is List<MyEvent?>?) {
      final myEvent = myEvents?.firstWhereOrNull(
        (e) => e?.id == eventId,
      );

      if (myEvent != null) {
        log("My Events In LocalService: ${myEvent.id}");
        context.pushNamed(
          MyEventDetails.routeName,
          extra: myEvent,
        );
      }
      return;
    }

    log("No event found with ID: $eventId");
  }

  void handleFirebaseMessage({
    required BuildContext context,
    required String? message,
  }) {
    if (message != null) {
      handleEvent(
        context,
        message,
      );
    } else {
      log("No event ID found in the notification data.");
    }
  }

  Future<void> handlePageRoute({
    required BuildContext context,
    String? pageName,
  }) async {
    if (pageName != null) {
      if (pageName == DetailsPage.routeName) {
        if (context.canPop()) {
          context.pop();
        }
      }
      context.pushNamed(pageName);
    }
    return;
  }

  Future<void> handleURL({required String url}) async {
    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}

@Riverpod(keepAlive: true)
HandleNotifications handleNotifications(Ref ref) {
  return HandleNotifications(
    eventsLocalService: ref.watch(eventsLocalServiceProvider),
    eventsRemoteService: ref.watch(eventRemoteServiceStateProvider),
    myEventsLocalService: ref.watch(myEventsLocalServiceProvider),
  );
}
