import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/core/services/share_app.dart';
import 'package:saudi_calender_task/core/widgets/ad_space.dart';
import '../../../../core/widgets/hijri_date.dart';
import '../../../../gen/assets.gen.dart';
import 'widgets/alert_warning.dart';
import 'widgets/category_list.dart';
import 'widgets/custom_event_widget.dart';
import 'widgets/news_list.dart';

class HomePage extends ConsumerWidget with ShareMixin {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        //this widget is ad space
        AdSpace(),
        //send gift widget
        Container(
          height: 43,
          width: double.infinity,
          color: const Color(0xffFFFAEF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.gift),
              const SizedBox(width: 4),
              const Text("اضغط هنا لارسال هدية لاحبابك"),
            ],
          ),
        ),
        //today hijri date and miladi date
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Text(
                hijriDateAndMiladi(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              //send app link with hijriDateAndMiladi
              GestureDetector(
                child: const Icon(Icons.share_outlined),
                onTapDown: (details) {
                  //share app
                  shareApp(
                    context,
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                    text: "تاريخ اليوم هجري و ميلادي ${hijriDateAndMiladi()}",
                  );
                },
              ),
            ],
          ),
        ),
        AlertWarning(),
        Expanded(
          child: ListView(
            shrinkWrap: false,
            children: [
              CategoryList(),
              NewsList(),
              Column(
                children: List.generate(
                  6,
                  (index) => CustomEventWidget(),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
