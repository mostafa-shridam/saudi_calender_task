import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../core/local_service/local_notification_service.dart';
import '../../core/theme/app_theme.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_model.dart';
import '../../remote_service/categories_service.dart';
import '../pages/details/details_page.dart';
import '../pages/home/widgets/event_data.dart';
import 'time_left.dart';

class CustomEventWidget extends ConsumerStatefulWidget {
  const CustomEventWidget({
    super.key,
    this.hideBorder = true,
    required this.eventModel,
  });

  final bool hideBorder;
  final EventModel eventModel;

  @override
  ConsumerState<CustomEventWidget> createState() => _CustomEventWidgetState();
}

class _CustomEventWidgetState extends ConsumerState<CustomEventWidget> {
  @override
  void initState() {
    super.initState();

    final localNotificationsService =
        ref.read(localNotificationsServiceProvider);

    try {
      final eventDate = DateTime.tryParse(
            widget.eventModel.eventDate?.split(" ")[0] ??
                DateTime.now().toString(),
          ) ??
          DateTime.now();

      localNotificationsService.showScheduleNotification(
        id: widget.eventModel.id.toString(),
        body: widget.eventModel.title ?? "",
        dateTime: eventDate,
        title: appName.toString(),
      );
    } catch (e) {
      log("Error showing notification: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoriesProvider.select((v) => v.data
        ?.firstWhereOrNull(
            (e) => e.id == widget.eventModel.section?.category?.id)));

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          DetailsPage.routeName,
          extra: widget.eventModel,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
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
                color: widget.hideBorder
                    ? Color(category?.backgroundColor ?? 0).withAlpha(20)
                    : null,
                border: Border.all(
                  width: 1,
                  color: widget.hideBorder
                      ? Colors.transparent
                      : graySwatch.shade200,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 16),
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
                      eventModel: widget.eventModel,
                    ),
                  ),
                  TimeLeft(
                    date: widget.eventModel.eventDate ??
                        DateTime.now().toIso8601String(),
                    color: widget.hideBorder,
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
