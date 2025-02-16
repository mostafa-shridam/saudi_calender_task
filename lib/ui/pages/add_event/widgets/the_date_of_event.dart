import 'package:flutter/material.dart';

class TheDateOfEvent extends StatelessWidget {
  const TheDateOfEvent({
    super.key,

    required this.date, this.onTap,
  });
  final String date;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
          color: Color(0xffF1F5F9),
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        child: Text(date),
      ),
    );
  }
}

