// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/models/event_model.dart';
import '../core/local_service/events_local_service.dart';
import '../remote_service/event_service.dart';
import '../ui/pages/details/details_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'generated/handle_notifications.g.dart';

class HandleNotifications {
  final EventsLocalService eventsLocalService;
  final EventRemoteService eventsRemoteService;

  HandleNotifications(
      {required this.eventsLocalService, required this.eventsRemoteService});
  Future<void> handleEvent(BuildContext context, String? eventId) async {
    EventModel? event;

    event = eventsLocalService.getEvents()?.data?.firstWhereOrNull(
          (e) => e.id == eventId.toString(),
        );

    if (event == null) {
      return;
    }

    context.pushNamed(
      DetailsPage.routeName,
      extra: event,
    );

    return;
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
  );
}
