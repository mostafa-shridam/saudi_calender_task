import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudi_calender_task/core/mixins/share_app.dart';
import 'package:saudi_calender_task/ui/pages/home/widgets/category_list.dart';
import 'package:saudi_calender_task/ui/widgets/ad_space.dart';
import 'package:saudi_calender_task/ui/widgets/send_gift.dart';
import 'package:saudi_calender_task/ui/widgets/today_date.dart';
import '../../../remote_service/event_service.dart';

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
        ref.watch(eventProvider.select((value) => value.filterdEvents));

    return Column(
      children: [
        //this widget is ad space
        AdSpace(),
        //send gift widget
        SendGift(),
        //today hijri date and miladi date
        TodayDate(),
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
