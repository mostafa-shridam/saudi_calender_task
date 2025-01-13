import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saudi_calender_task/models/event_model.dart';

import '../../../gen/assets.gen.dart';
import '../../../remote_service/event_service.dart';
import '../../widgets/ad_space.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/event_date_details.dart';
import '../../widgets/share_object.dart';
import '../../widgets/custom_event_widget.dart';
import '../home/widgets/category_list.dart';
import 'widgets/news_list_in_details.dart';
import 'widgets/remaining_widget.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({
    super.key,
    required this.event,
  });
  final EventModel event;
  static const routeName = '/Details';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventProvider).events?.data;
    events?.removeWhere((element) => element.id == event.id);
    if (events == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdSpace(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  Assets.images.saudiPoster.path,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    AutoSizeText(
                      event.title ?? '',
                      maxFontSize: 24,
                      minFontSize: 19,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff245D3A),
                      ),
                    ),
                    Spacer(),
                    CategoryItem(
                      isSelected: false,
                      icon: Assets.images.gift,
                      color: 0xff6B7DCF,
                      label: event.section?.category?.name ?? '',
                    ),
                  ],
                ),
              ),
              EventDateDetails(
                date: event.eventDate ?? '',
              ),
              RemainingWidget(),
              CustomDivider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: AutoSizeText(
                  "احداث قادمة",
                  maxFontSize: 19,
                  minFontSize: 18,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CustomEventWidget(
                    hideBorder: false,
                    eventModel: events[index],
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: AutoSizeText(
                  "أخر الاخبار",
                  maxFontSize: 19,
                  minFontSize: 18,
                ),
              ),
              NewsListInDetails(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CutomShareObjectRow(
        text: "${event.title}\n${event.eventDate}",
      ),
    );
  }
}
