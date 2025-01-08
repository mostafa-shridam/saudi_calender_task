import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/ad_space.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/event_date_details.dart';
import '../../widgets/share_object.dart';
import '../../widgets/custom_event_widget.dart';
import 'widgets/news_list_in_details.dart';
import 'widgets/remaining_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  static const routeName = '/Details';
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
              EventDateDetails(
                date: "2025-02-08 14:00:00",
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
                    hideBorder: false,
                    color: 0xff6B7DCF,
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
      bottomNavigationBar: CutomShareObjectRow(),
    );
  }
}
