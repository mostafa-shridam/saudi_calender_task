import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/services/app_theme.dart';

class RestOfTheEvent extends StatelessWidget {
  const RestOfTheEvent({
    super.key,
    required this.textNumber,
    required this.date,
    this.textColor,
    this.color = false,
  });
  final bool color;
  final String textNumber, date;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color == false ? graySwatch.shade50 : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
      ),
      width: 56,
      height: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            textNumber,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (date.isNotEmpty)
            Text(
              date,
              style: TextStyle(
                color: textColor ?? Color(0xff475569),
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
