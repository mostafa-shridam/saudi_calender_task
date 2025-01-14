import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/models/event_model.dart';
import 'package:saudi_calender_task/ui/widgets/time_left.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../core/local_service/local_notification_service.dart';
import '../../gen/assets.gen.dart';
import '../../remote_service/categories_service.dart';
import '../pages/details/details_page.dart';
import '../pages/home/widgets/event_data.dart';

class CustomEventWidget extends ConsumerWidget {
  const CustomEventWidget({
    super.key,
    this.hideBorder = true,
    required this.eventModel,
  });
  final bool hideBorder;
  final EventModel eventModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoriesProvider.select((v) => v.data
        ?.firstWhereOrNull((e) => e.id == eventModel.section?.category?.id)));
    try {
    final eventNotify =  ref.watch(localNotificationsServiceProvider).showNotification(
            id: eventModel.id.toString(),
            body: "",
            dateTime: DateTime.tryParse(eventModel.startsAt?.split(" ")[0] ??
                    DateTime.now().toString()) ??
                DateTime.now(),
            title: eventModel.title.toString(),
            
          );
          log("eventNotify: $eventNotify");
    } catch (e) {
      log("Error showing notification: $e");
    }
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          DetailsPage.routeName,
          extra: eventModel,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerRight,
          children: [
            Container(
              height: 72,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                color: hideBorder
                    ? Color(category?.backgroundColor ?? 0).withAlpha(20)
                    : null,
                border: Border.all(
                  width: 1,
                  color: hideBorder ? Colors.transparent : graySwatch.shade200,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: graySwatch.shade100),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          Assets.images.eventImage.path,
                        ),
                      ),
                    ),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 298,
                    child: EventData(
                      eventModel: eventModel,
                    ),
                  ),
                  TimeLeft(
                    date: eventModel.eventDate ??
                        DateTime.now().toIso8601String(),
                    color: hideBorder,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(category?.backgroundColor ?? 0),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              width: 2,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
