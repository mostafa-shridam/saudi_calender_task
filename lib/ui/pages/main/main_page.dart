// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:saudi_calender_task/gen/assets.gen.dart';
import 'package:saudi_calender_task/ui/pages/home/home_page.dart';

import '../../../core/local_service/local_notification_service.dart';
import '../../../core/mixins/share_app.dart';
import '../../widgets/home_app_bar.dart';

class MainPage extends ConsumerStatefulWidget with ShareMixin {
  const MainPage({super.key});
  static const String routeName = '/MainPage';

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(localNotificationsServiceProvider).initNotify(
            context,
          );
      ref.watch(localNotificationsServiceProvider).initOneSignal();
      ref.watch(localNotificationsServiceProvider).initFirebaseMessaging(context: context);
      ref
          .watch(localNotificationsServiceProvider)
          .oneSignalNotifications(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        onTapDown: (details) {
          widget.shareApp(
            context,
            details.globalPosition.dx,
            details.globalPosition.dy,
            text: kShareAppUrl,
          );
        },
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

List<Widget> screens = [
  HomePage(),
  const Center(child: Text("مناسباتي")),
  const Center(child: Text("الأخبار")),
  const Center(child: Text("الاعدادات")),
  const Center(
      child: Text(
    "تطبيقاتنا",
  )),
];
