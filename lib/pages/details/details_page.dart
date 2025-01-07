import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/core/widgets/ad_space.dart';
import 'package:saudi_calender_task/core/widgets/custom_divider.dart';
import 'package:saudi_calender_task/pages/details/widgets/news_list_in_details.dart';
import 'package:saudi_calender_task/pages/details/widgets/remaining_widget.dart';

import '../../core/services/app_theme.dart';
import '../../core/services/share_app.dart';
import '../../gen/assets.gen.dart';
import '../main/widgets/home/widgets/custom_event_widget.dart';

class DetailsPage extends StatelessWidget with ShareMixin {
  const DetailsPage({super.key});
  static const routeName = '/details';
  @override
  Widget build(BuildContext context) {
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
                  Assets.images.rectangle19591.path,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Text(
                      "اليوم الوطني",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xff245D3A),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 36,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: graySwatch.shade100,
                            width: 1,
                          )),
                      child: Row(children: [
                        SvgPicture.asset(Assets.images.calendar2),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "مناسبات",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: graySwatch.shade600,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              EventDate(),
              Divider(
                endIndent: 16,
                thickness: 1,
                color: graySwatch.shade100,
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
                itemCount: 2,
                itemBuilder: (context, index) {
                  return CustomEventWidget(
                    navigate: false,
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
      bottomNavigationBar: SizedBox(
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
              icon: Assets.images.share,
              label: "مشاركة",
            ),
          ],
        ),
      ),
    );
  }
}

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
