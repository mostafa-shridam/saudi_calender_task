import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/ui/widgets/count_down_timer.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';

import '../../gen/assets.gen.dart';

class EventDateDetails extends StatelessWidget {
  const EventDateDetails({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(hijriDateAndMiladiDate(
            date: date,
          )),
          SizedBox(
            height: 6,
          ),
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(Assets.images.timer),
              CountDownTimer(
                date: date,
                makeAsRow: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
