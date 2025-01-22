import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({super.key, required this.date, this.makeAsRow = false});
  final String date;
  final bool makeAsRow;
  @override
  Widget build(BuildContext context) {
    final DateTime endTimeDateTime = DateTime.parse(date.split(" ")[0]);

    final int endTime = endTimeDateTime.millisecondsSinceEpoch;

    return CountdownTimer(
      onEnd: () {},
      endTime: endTime,
      widgetBuilder: (_, time) {
        // If no time is left, return a default message
        if (time == null) {
          return Center(
              child: Text(
            defultEnd,
            style: Theme.of(context).textTheme.labelMedium,
          ));
        }
        final daysText = (time.days ?? 0) < 10 ? 'أيام' : 'يوم';
        final hoursText = (time.hours ?? 0) < 10 ? 'ساعات' : 'ساعة';
        final minutesText = (time.min ?? 0) < 10 ? 'دقائق' : 'دقيقة';
        final secondsText = (time.sec ?? 0) < 10 ? 'ثواني' : 'ثانية';

        if (makeAsRow) {
          return RichText(
            text: TextSpan(
              text: "${(time.days ?? 0) > 0 ? time.days ?? 0 : ""}",
              style: Theme.of(context).textTheme.headlineMedium,
              children: [
                if ((time.days ?? 0) > 0) ...[
                  TextSpan(
                    text: ' $daysText : ',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
                TextSpan(text: '${time.hours ?? 0}'),
                TextSpan(
                  text: ' $hoursText :',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                TextSpan(text: ' ${time.min ?? 0}'),
                TextSpan(
                  text: ' $minutesText',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                if ((time.days ?? 0) == 0) ...[
                  TextSpan(
                    text: ' : ',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  TextSpan(
                    text: ' ${time.sec ?? 0}',
                  ),
                  TextSpan(
                    text: ' $secondsText',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ],
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show days if available
              if ((time.days ?? 0) > 0)
                Text(
                  "${time.days ?? 0}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              if ((time.days ?? 0) > 0)
                Text(
                  daysText,
                  style: TextStyle(
                    color: graySwatch.shade600,
                    fontSize: 12,
                  ),
                ),

              // Show hours if under 1 day
              if ((time.days ?? 0) == 0 && (time.hours ?? 0) > 0)
                Text(
                  "${time.hours ?? 0}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              if ((time.days ?? 0) == 0 && (time.hours ?? 0) > 0)
                Text(
                  hoursText,
                  style: TextStyle(
                    color: graySwatch.shade600,
                    fontSize: 12,
                  ),
                ),

              // Show minutes if under 1 hours
              if ((time.days ?? 0) == 0 &&
                  (time.hours ?? 0) == 0 &&
                  (time.min ?? 0) > 0)
                Text(
                  "${time.min ?? 0}",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color:
                            time.min! < 10 ? Colors.red : graySwatch.shade900,
                      ),
                ),
              if ((time.days ?? 0) == 0 &&
                  (time.hours ?? 0) == 0 &&
                  (time.min ?? 0) > 0)
                Text(
                  minutesText,
                  style: TextStyle(
                    color: time.min! < 10 ? Colors.red : graySwatch.shade600,
                    fontSize: 12,
                  ),
                ),

              // Show seconds if under 1 minute left
              if ((time.days ?? 0) == 0 &&
                  (time.hours ?? 0) == 0 &&
                  (time.min ?? 0) > 0 &&
                  (time.sec ?? 0) > 0)
                Text(
                  "${time.sec ?? 0}",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.red,
                      ),
                ),
              if ((time.days ?? 0) == 0 &&
                  (time.hours ?? 0) == 0 &&
                  (time.min ?? 0) > 0 &&
                  (time.sec ?? 0) > 0)
                Text(
                  secondsText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
