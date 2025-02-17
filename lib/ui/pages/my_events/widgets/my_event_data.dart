import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/models/my_event.dart';
import 'package:saudi_calender_task/ui/pages/my_event_details/my_event_details.dart';
import 'package:saudi_calender_task/ui/widgets/time_left.dart';

import '../../../../constants.dart';
import '../../../../core/local_service/local_notification_service.dart';
import '../../../widgets/hijri_date.dart';

class MyEventData extends ConsumerStatefulWidget {
  const MyEventData({super.key, required this.myEvent});
  final MyEvent myEvent;

  @override
  ConsumerState<MyEventData> createState() => _MyEventDataState();
}

class _MyEventDataState extends ConsumerState<MyEventData> {
  Future<void> _notification() async {
    final localNotificationsService =
        ref.read(localNotificationsServiceProvider);

    try {
      final eventDate = DateTime.tryParse(
            widget.myEvent.eventDate?.split(" ")[0] ??
                DateTime.now().toString(),
          ) ??
          DateTime.now();

      final result = await localNotificationsService.showScheduleNotification(
        id: widget.myEvent.id.hashCode,
        body: widget.myEvent.title ?? "",
        dateTime: eventDate,
        title: appName.toString(),
      );
      if (result) {
        log("Notification shown");
      }
    } catch (e) {
      log("Error showing notification: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _notification());
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = parseEventDate(
        date: widget.myEvent.eventDate ?? DateTime.now().toIso8601String());
    return GestureDetector(
      onTap: () =>
          context.pushNamed(MyEventDetails.routeName, extra: widget.myEvent),
      child: Container(
        color: Colors.white,
        width: 382,
        height: 78,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                height: 74,
                width: 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(
                      widget.myEvent.category?.color ?? graySwatch.toARGB32()),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    widget.myEvent.title ?? "",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    formattedDate,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Color(0xff475569)),
                  ),
                  Text(
                    widget.myEvent.startsAt ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Color(0xff475569)),
                  ),
                ],
              ),
              const Spacer(),
              TimeLeft(
                date: widget.myEvent.eventDate ??
                    DateTime.now().toIso8601String(),
                color: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
