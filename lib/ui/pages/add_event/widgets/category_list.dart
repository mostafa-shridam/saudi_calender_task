import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class CategoryList {
  static const List<String> categoryList = [
    'عام', // General
    'عائلة', // Family
    'عمل', // Work
    'شخصي', // Personal
    'اجتماع', // Meeting
    'أخرى', // Others
  ];

  static const List<Color> colorList = [
    primaryColor,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
  ];
}

class RepeatList {
  static const List<String> repeatList = [
    'ابدا',
    'يومي',
    'اسبوعي',
    'شهري',
  ];
}

class PriorityList {
  static const List<String> repeatList = [
    "منخفض",
    "متوسط",
    "مرتفع",
  ];
}
