import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/gen/assets.gen.dart';

import '../services/app_theme.dart';
import '../services/share_app.dart';

class EventDate extends StatefulWidget {
  const EventDate({super.key});

  @override
  State<EventDate> createState() => _EventDateState();
}

class _EventDateState extends State<EventDate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("الاربعاء 19 يوليو 2023 - 1 محرم 1445"),
          SizedBox(
            height: 6,
          ),
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(Assets.images.timer),
              Text("5 ايام : 8 ساعات : 10 دقائق"),
            ],
          ),
        ],
      ),
    );
  }
}

class ShareObject extends StatelessWidget {
  const ShareObject(
      {super.key,
      required this.onTapDown,
      required this.icon,
      required this.label});
  final void Function(TapDownDetails)? onTapDown;
  final String icon, label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: Container(
        height: 74,
        width: 187,
        decoration: BoxDecoration(
            color: graySwatch.shade50, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            Text(
              label,
            ),
          ],
        ),
      ),
    );
  }
}

class CutomShareObjectRow extends StatelessWidget with ShareMixin {
  const CutomShareObjectRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          ShareObject(
            onTapDown: (details) {
              whatsAppMessage(
                text: "$kShareAppName $kShareAppUrl",
              );
            },
            icon: Assets.images.whatsapp,
            label: "واتساب",
          ),
          ShareObject(
            onTapDown: (details) {
              shareApp(
                context,
                details.globalPosition.dx,
                details.globalPosition.dy,
              );
            },
            icon: Assets.images.export,
            label: "مشاركة",
          ),
        ],
      ),
    );
  }
}
