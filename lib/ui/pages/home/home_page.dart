import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saudi_calender_task/core/mixins/share_app.dart';
import 'package:saudi_calender_task/ui/pages/home/widgets/category_list.dart';
import 'package:saudi_calender_task/ui/widgets/ad_space.dart';
import '../../../remote_service/event_service.dart';
import '../../widgets/hijri_date.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/alert_warning.dart';
import '../../widgets/custom_event_widget.dart';
import 'widgets/news_list.dart';

class HomePage extends ConsumerWidget with ShareMixin {
  const HomePage({
    super.key,
  });
  static const routeName = '/HomePage';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events =
        ref.watch(eventProvider.select((value) => value.fliteredList));

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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                hijriDateAndMiladiDate(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              //send app link with hijriDateAndMiladi
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Icon(Icons.share_outlined),
                ),
                onTapDown: (details) {
                  //share app
                  shareApp(
                    context,
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                    text:
                        "تاريخ اليوم هجري و ميلادي ${hijriDateAndMiladiDate()}",
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
              if (events.isEmpty)
                const Center(
                  child: SizedBox(
                    height: 180,
                  ),
                ),
              if (events.isEmpty)
                const Center(
                  child: Text("لا يوجد مناسبات"),
                ),
              Column(
                children: List.generate(
                  events.length,
                  (index) => CustomEventWidget(
                    eventModel: events[index],
                  ),
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
