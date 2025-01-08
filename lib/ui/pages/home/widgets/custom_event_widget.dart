import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';
import 'package:saudi_calender_task/ui/pages/home/widgets/time_left.dart';

import '../../../../gen/assets.gen.dart';
import '../../details/details_page.dart';
import 'event_data.dart';

class CustomEventWidget extends StatelessWidget {
  const CustomEventWidget({
    super.key,
    this.hideBorder = true,
    required this.color,
  });
  final bool hideBorder;
  final int color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideBorder ? context.pushNamed(DetailsPage.routeName) : null;
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
                color: hideBorder ? Color(color).withAlpha(20) : null,
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
                    child: EventData(),
                  ),
                  TimeLeft(
                    time: "2025-01-08 10:30:00",
                    color: hideBorder,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(color),
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
