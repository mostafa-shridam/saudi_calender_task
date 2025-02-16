import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';


void customShowSnackBar(BuildContext context,
    {required String message, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: color ?? primaryColor.withAlpha(200),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
