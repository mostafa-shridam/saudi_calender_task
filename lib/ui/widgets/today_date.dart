import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/mixins/share_app.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';

class TodayDate extends StatelessWidget with ShareMixin {
  const TodayDate({super.key, this.color = Colors.transparent});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: color,
      child: Row(
        children: [
          SizedBox(width: 16),
          Text(
            hijriDateAndMiladiDate(),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          //send app link with hijriDateAndMiladi
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Icon(Icons.share_outlined),
            ),
            onTapDown: (details) {
              //share app
              shareApp(
                context,
                details.globalPosition.dx,
                details.globalPosition.dy,
                text: "تاريخ اليوم هجري و ميلادي ${hijriDateAndMiladiDate()}",
              );
            },
          ),
        ],
      ),
    );
  }
}
