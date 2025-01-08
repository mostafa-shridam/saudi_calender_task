import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';

import '../../../widgets/hijri_date.dart';

class TimeLeft extends StatefulWidget {
  const TimeLeft({
    super.key,
    this.color = false, required this.time,
  });
  final bool color;
  final String time;
  @override
  State<TimeLeft> createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  late Timer _timer;
  String timeValue = "انتهي";
  String timeName = "";
  Color? textColor;

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
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  void updateTime() {
    final time = widget.time;
    final eventDate = DateTime.parse(time);

    final days = CustomDates().dateInDays(eventDate.toString());
    final hours = CustomDates().dateInHours(eventDate.toString());
    final minutes = CustomDates().dateInMinutes(eventDate.toString());
    final minutesRedText =
        CustomDates().dateInMinutesWithRedTextColor(eventDate.toString());
    final seconds = CustomDates().dateInSeconds(eventDate.toString());

    if (eventDate.isBefore(DateTime.now())) {
      timeValue = "منتهي";
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
      timeValue = "منتهي";
      timeName = "";
      textColor = Colors.black;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color ? Colors.white : graySwatch.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      width: 56,
      height: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            timeValue,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (timeName.isNotEmpty)
            Text(
              timeName,
              style: TextStyle(
                color: textColor ?? const Color(0xff475569),
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
