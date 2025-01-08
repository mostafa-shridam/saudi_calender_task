import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';
import 'package:saudi_calender_task/ui/pages/home/widgets/time_left.dart';

import '../../../../gen/assets.gen.dart';
import '../../details/details_page.dart';
import 'event_data.dart';

class CustomEventWidget extends StatefulWidget {
  const CustomEventWidget({
    super.key,
    this.hideBorder = true,
    required this.color,
  });
  final bool hideBorder;
  final int color;
  @override
  State<CustomEventWidget> createState() => _CustomEventWidgetState();
}

class _CustomEventWidgetState extends State<CustomEventWidget> {
  late Timer _timer;
  late String timeValue;
  late String timeName;
  late Color textColor;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
    });
    updateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

//time left calculation
  void updateTime() {
    List<String> time = [
      "2025-01-08 09:50:00",
      "2025-01-09 10:50:00",
      "2025-01-27 10:50:00",
      "2025-04-07 12:50:00",
      "2025-02-09 10:50:00",
      "2025-08-27 10:50:00",
    ];

    // Target event date and time
    final eventDate = DateTime.parse(time[0]);

    // Time remaining calculation
    final days = CustomDates().dateInDays(eventDate.toString());
    final hours = CustomDates().dateInHours(eventDate.toString());
    final minutes = CustomDates().dateInMinutes(eventDate.toString());
    final minutesRedText =
        CustomDates().dateInMinutesWithRedTextColor(eventDate.toString());
    final seconds = CustomDates().dateInSeconds(eventDate.toString());

    if (eventDate.isBefore(DateTime.now())) {
      //if time left is less than 0025-01-07 10:50:00"
      timeValue = "End";
      timeName = "";
      textColor = Colors.black;
    } else if (days != defultEnd) {
      timeValue = days;
      timeName = "يوم";
      textColor = Colors.black;
    } else if (hours != defultEnd) {
      timeValue = hours;
      timeName = "ساعة";
      textColor = Colors.black;
    } else if (minutes != defultEnd) {
      // if time left is less than 10 minutes
      if (minutesRedText != defultEnd) {
        timeValue = minutesRedText;
        timeName = "دقيقة";
        textColor = Colors.red;
      } else {
        timeValue = minutes;
        timeName = "دقيقة";
        textColor = Colors.black;
      }
    } else if (seconds != defultEnd) {
      timeValue = seconds;
      timeName = "ثانية";
      textColor = Colors.red;
    } else {
      //if time left is less than 0

      timeValue = "End";
      timeName = "";
      textColor = Colors.black;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.hideBorder ? context.pushNamed(DetailsPage.routeName) : null;
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
                color: widget.hideBorder
                    ? Color(widget.color).withAlpha(20)
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
                    child: EventData(),
                  ),
                  TimeLeft(
                    textNumber: timeValue,
                    date: timeName.isEmpty ? "" : timeName,
                    textColor: textColor,
                    color: widget.hideBorder,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(widget.color),
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
