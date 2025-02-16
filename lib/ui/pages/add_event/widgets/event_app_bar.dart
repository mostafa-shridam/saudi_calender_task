import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

// event app bar for add and edit
AppBar eventAppBar(
    {required String title,
    required BuildContext context,
    required String textButton,
    required void Function() onTap}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    leading: TextButton(
      style: TextButton.styleFrom(foregroundColor: Colors.red),
      child: const Text("إلغاء"),
      onPressed: () => context.pop(),
    ),
    leadingWidth: 90,
    actions: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsetsDirectional.only(end: 12),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
          ),
          child: Text(
            textButton,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
