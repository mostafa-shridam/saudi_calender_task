import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

mixin ShareMixin {
  Future<void> shareApp(BuildContext context, double x, double y,
      {String? text}) async {
    {
      await Share.share(
        text ?? "$kShareAppName $kShareAppUrl",
        subject: kShareAppName,
        sharePositionOrigin: Rect.fromLTWH(x, y, 10, 10),
      );
    }
  }

  Future<void> whatsAppMessage({required String text}) async {
    try {
      await launchUrl(
        Uri.parse('whatsapp://send?text=${Uri.encodeComponent(text)}'),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      log('Error Sharing whatsapp $e');
    }
  }
}

const kShareAppUrl = 'https://play.google.com/store/apps/details?id=com.example.saudiCalenderTask';

const kShareAppName = 'تطبيق سعودي التقويم';