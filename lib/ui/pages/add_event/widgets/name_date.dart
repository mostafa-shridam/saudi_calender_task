// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import 'list_tile_date_of_event.dart';
import 'select_event_date.dart';

class DateWidget extends ConsumerStatefulWidget {
  const DateWidget({
    super.key,
    required this.nameDate,
    required this.startsAt,
    required this.eventDate,
    this.date,
    this.time,
  });

  final ValueChanged<String> startsAt, eventDate;
  final String nameDate;
  final String? date, time;

  @override
  ConsumerState<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends ConsumerState<DateWidget> {
  DateTime? dateSelected;
  TimeOfDay? timeSelected;

  @override
  Widget build(BuildContext context) {
    return ListTileDateOfEvent(
      onTapDate: () async {
        final date = await selectDate(context, dateSelected);
        if (date != null) {
          setState(() {
            dateSelected = date;
            updateDateAndTime();
          });
          final time =
              await selectTime(context: context, isSelectedTime: timeSelected);
          if (time != null) {
            setState(() {
              timeSelected = time;
              updateDateAndTime();
            });
          }
        }
      },
      onTapTime: () async {
        final time =
            await selectTime(context: context, isSelectedTime: timeSelected);
        if (time != null) {
          setState(() {
            timeSelected = time;
            updateDateAndTime();
          });
        }
      },
      nameDate: widget.nameDate,
      date: dateSelected != null
          ? DateFormat(selectedDateFormat, "ar")
              .format(dateSelected ?? DateTime.now())
          : widget.date == null
              ? "أختر التاريخ"
              : widget.date ?? "",
      time: timeSelected != null
          ? timeSelected!.format(context)
          : widget.time == null
              ? "أختر الوقت"
              : widget.time ?? "",
    );
  }

  void updateDateAndTime() async {
    if (dateSelected != null && timeSelected != null) {
      final formatterDate = DateTime(
        dateSelected?.year ?? DateTime.now().year,
        dateSelected?.month ?? DateTime.now().month,
        dateSelected?.day ?? DateTime.now().day,
        timeSelected?.hour ?? DateTime.now().hour,
        timeSelected?.minute ?? DateTime.now().minute,
      );
      widget.eventDate(DateFormat(eventsDateFormat).format(formatterDate));
      widget.startsAt(timeSelected!.format(context));
    } else {
      return;
    }
  }
}
