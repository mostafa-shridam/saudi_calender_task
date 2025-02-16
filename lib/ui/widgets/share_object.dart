import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/gen/assets.gen.dart';

import '../../core/theme/app_theme.dart';
import '../../core/mixins/share_app.dart';

class ShareObject extends StatelessWidget {
  const ShareObject({
    super.key,
    this.onTapDown,
    required this.icon,
    required this.label,
    this.color,
    this.width = 187,
    this.onTap,
  });
  final void Function(TapDownDetails)? onTapDown;
  final void Function()? onTap;
  final String icon, label;
  final Color? color;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTap: onTap,
      child: Container(
        height: 74,
        width: width,
        decoration: BoxDecoration(
          color: graySwatch.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            color == null
                ? SvgPicture.asset(
                    icon,
                  )
                : SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
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
  const CutomShareObjectRow({super.key, this.text});
  final String? text;
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
                text: text != null
                    ? "$kShareAppName\n$text\n$kShareAppUrl"
                    : "$kShareAppName $kShareAppUrl",
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
                text: text != null
                    ? "$kShareAppName\n$text\n$kShareAppUrl"
                    : "$kShareAppName $kShareAppUrl",
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
