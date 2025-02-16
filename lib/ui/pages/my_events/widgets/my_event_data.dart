import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/extension/color.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/models/my_event.dart';
import 'package:saudi_calender_task/ui/pages/my_event_details/my_event_details.dart';
import 'package:saudi_calender_task/ui/widgets/time_left.dart';

import '../../../widgets/hijri_date.dart';

class MyEventData extends StatelessWidget {
  const MyEventData({super.key, required this.myEvent});
  final MyEvent myEvent;
  @override
  Widget build(BuildContext context) {
    final formattedDate = parseEventDate(
        date: myEvent.eventDate ?? DateTime.now().toIso8601String());
    return GestureDetector(
      onTap: () => context.pushNamed(MyEventDetails.routeName, extra: myEvent),
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
                  color: Color(myEvent.color ?? graySwatch.toARGB32),
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
                    myEvent.title ?? "",
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
                    myEvent.startsAt ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Color(0xff475569)),
                  ),
                ],
              ),
              const Spacer(),
              TimeLeft(
                date: myEvent.eventDate ?? DateTime.now().toIso8601String(),
                color: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
