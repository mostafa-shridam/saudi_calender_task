import 'package:flutter/material.dart';

Future<DateTime?> selectDate(
    BuildContext context, DateTime? isSelectdDate) async {
  return await showDatePicker(
    context: context,
    initialDate: isSelectdDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
}

Future<TimeOfDay?> selectTime(
    {required BuildContext context, TimeOfDay? isSelectedTime}) async {
  return await showTimePicker(
    context: context,
    initialTime: isSelectedTime ?? TimeOfDay.now(),
  );
}
