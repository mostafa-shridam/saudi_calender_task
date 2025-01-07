import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/services/app_theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 12,
      thickness: 12,
      color: graySwatch.shade200,
    );
  }
}
