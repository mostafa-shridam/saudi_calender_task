import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:saudi_calender_task/gen/assets.gen.dart';
import 'package:saudi_calender_task/pages/main/widgets/home/home_page.dart';

import '../../core/services/share_app.dart';
import '../../core/widgets/home_app_bar.dart';

class MainPage extends StatefulWidget with ShareMixin {
  const MainPage({super.key});
  static const String routeName = '/MainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0
          ? homeAppBar(
              onTapDown: (details) {
                widget.shareApp(
                  context,
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  text: kShareAppUrl,
                );
              },
            )
          : AppBar(
              title: Text(title[currentIndex]),
            ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(currentIndex == 0
                ? Assets.images.calendarGreen
                : Assets.images.calendarUnsSelected),
            icon: SvgPicture.asset(Assets.images.calendar2),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.images.calendar,
              colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? Color(0xff245D3A) : Color(0xff64748B),
                  BlendMode.srcIn),
            ),
            label: "مناسباتي",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.images.documentText,
            ),
            label: "الأخبار",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.images.setting2,
            ),
            label: "الاعدادات",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.images.mobile,
            ),
            label: "تطبيقاتنا",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

List<Widget> screens = const [
  HomePage(),
  Center(child: Text("مناسباتي")),
  Center(child: Text("الأخبار")),
  Center(child: Text("الاعدادات")),
  Center(
      child: Text(
    "تطبيقاتنا",
  )),
];

List<String> title = [
  "",
  "مناسباتي",
  "الأخبار",
  "الاعدادات",
  "تطبيقاتنا",
];
