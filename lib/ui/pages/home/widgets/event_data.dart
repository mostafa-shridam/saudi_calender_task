import 'package:flutter/material.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';


class EventData extends StatelessWidget {
  const EventData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = eventDate(
      "2023-05-01",
    );

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            "بداية العام الهجري 1445",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            formattedDate,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
