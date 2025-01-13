import 'package:flutter/material.dart';
import 'package:saudi_calender_task/models/event_model.dart';
import 'package:saudi_calender_task/ui/widgets/hijri_date.dart';

class EventData extends StatelessWidget {
  const EventData({
    super.key,
    required this.eventModel,
  });
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    final formattedDate = parseEventDate(
        date: eventModel.eventDate ?? DateTime.now().toIso8601String());
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            eventModel.title ?? '',
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
