import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/extension/color.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.thickness = 8,
  });
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color:  Color(graySwatch.shade100.toARGB32),
    );
  }
}
