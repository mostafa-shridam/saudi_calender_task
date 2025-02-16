import 'package:flutter/material.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
     this.onChanged,
    this.keyboardType,
    this.maxLines,
    this.verticalPadding,
    this.hint,
    this.horizontalPadding,
    this.validator,
    this.fillColor = Colors.white,
    this.withBorder = false,
  });

  final int? maxLines;
  final double? verticalPadding;
  final double? horizontalPadding;
  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color fillColor;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 12,
          vertical: verticalPadding ?? 12,
        ),
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintText: hint,
        fillColor: fillColor,
        filled: true,
        border: withBorder ? _buildBorder() : InputBorder.none,
        disabledBorder: withBorder ? _buildBorder() : InputBorder.none,
        enabledBorder: withBorder ? _buildBorder() : InputBorder.none,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: graySwatch.shade200,
        width: 1,
      ),
    );
  }
}
