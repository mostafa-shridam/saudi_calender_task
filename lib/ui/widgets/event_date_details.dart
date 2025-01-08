import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';

class EventDate extends StatelessWidget {
  const EventDate({super.key});

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
