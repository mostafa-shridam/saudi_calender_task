import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saudi_calender_task/core/services/app_theme.dart';
import 'package:saudi_calender_task/core/widgets/hijri_date.dart';
import 'package:saudi_calender_task/pages/main/widgets/home/widgets/rest_of_the_event.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../details/details_page.dart';
import 'event_data.dart';

class CustomEventWidget extends StatefulWidget {
  const CustomEventWidget({
    super.key,
    this.navigate = true,
  });
  final bool navigate;
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

  void updateTime() {
    final dateNow = DateTime.parse("2025-01-06 17:09:00");
    final currentDateFormatted =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateNow);
    final days = CustomDates().dateInDayes(currentDateFormatted);
    final hours = CustomDates().dateInHours(currentDateFormatted);
    final minutes = CustomDates().dateInMinutes(currentDateFormatted);
    final seconds = CustomDates().dateInSeconds(currentDateFormatted);

    final eventTime = parseDate(currentDateFormatted);
    if (eventTime.isBefore(DateTime.now())) {
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
      timeValue = minutes;
      timeName = "دقيقة";
      textColor = Colors.red;
    } else if (seconds != defultEnd) {
      timeValue = seconds;
      timeName = "ثانية";
      textColor = Colors.red;
    } else {
      timeValue = "End";
      timeName = "";
      textColor = Colors.red;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.navigate ? context.pushNamed(DetailsPage.routeName) : null;
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
                color: widget.navigate ? Color(0xff6B7DCF).withAlpha(20) : null,
                border: Border.all(
                  width: 1,
                  color: widget.navigate
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
                          Assets.images.rectangle195451.path,
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
                  RestOfTheEvent(
                    textNumber: timeValue,
                    date: timeName.isEmpty ? "" : timeName,
                    textColor: textColor,
                    color: widget.navigate,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff6B7DCF),
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
