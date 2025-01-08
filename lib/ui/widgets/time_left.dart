import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/ui/widgets/count_down_timer.dart';

class TimeLeft extends StatelessWidget {
  const TimeLeft({
    super.key,
    required this.date,
    required this.color,
  });
  final bool color;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color == true ? Colors.white : graySwatch.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      width: 56,
      height: 56,
      child: CountDownTimer(
        date: date,
      ),
    );
  }
}
