import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saudi_calender_task/gen/assets.gen.dart';

homeAppBar({
  void Function(TapDownDetails)? onTapDown,
}) {
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16.0),
        child: Image.asset(
          Assets.images.icon.path,
        ),
      ),
    ),
    actions: [
      GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          width: 105,
          height: 28,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: [
              Text(
                "اخفاء الاعلانات",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              SvgPicture.asset(
                Assets.images.gallerySlash,
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 16),
      GestureDetector(
        ///here is the share button on app bar
        onTapDown: onTapDown,
        child: SvgPicture.asset(Assets.images.share),
      ),
      SizedBox(
        width: 16,
      )
    ],
  );
}
