import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/gen/assets.gen.dart';

class AlertWarning extends StatelessWidget {
  const AlertWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: double.infinity,
      color: const Color(0xffFDF6B2),
      child: Row(
        children: [
          const SizedBox(width: 16),
          SvgPicture.asset(Assets.images.bellActiveAlt),
          const SizedBox(width: 4),
          const Text(
            "تنبية",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const Text(
            " التطبيق غير رسمي ولا يتبع لجهة حكومية",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
