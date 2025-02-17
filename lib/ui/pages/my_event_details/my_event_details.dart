import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saudi_calender_task/core/theme/app_theme.dart';
import 'package:saudi_calender_task/gen/assets.gen.dart';
import 'package:saudi_calender_task/models/my_event.dart';
import 'package:saudi_calender_task/ui/widgets/count_down_timer.dart';
import '../../widgets/custom_list_tile_category_items.dart';
import '../../widgets/hijri_date.dart';
import '../home/widgets/category_list.dart';
import 'widgets/bottom_row_for_my_event_details.dart';

class MyEventDetails extends ConsumerWidget {
  const MyEventDetails({super.key, required this.myEvent});
  static const routeName = '/my_event_details';
  final MyEvent myEvent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate =
        parseEventDate(date: myEvent.eventDate ?? DateTime.now().toString());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: graySwatch.shade100,
            height: 198,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                Row(
                  children: [
                    Text(
                      myEvent.title ?? "",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Color(0xff245D3A),
                              ),
                    ),
                    Spacer(),
                    CategoryItem(
                      isSelected: true,
                      icon: "",
                      label: myEvent.category?.name ?? "عام",
                      color: myEvent.category?.color?.toInt() ??
                          Colors.white.toARGB32(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.images.calendar),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Assets.images.calendar),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      myEvent.startsAt ?? "",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.images.timer),
                    SizedBox(
                      width: 8,
                    ),
                    CountDownTimer(
                      date: myEvent.eventDate ?? DateTime.now().toString(),
                      makeAsRow: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          CustomListTileCategoryItems(
            tap: false,
            categories: myEvent.category,
            alert: (value) {},
            category: (v) {},
            repeat: (value) {},
          ),
          Spacer(),
          BottomRowForMyEventDetails(
            myEvent: myEvent,
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}

