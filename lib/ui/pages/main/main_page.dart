// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:saudi_calender_task/gen/assets.gen.dart';
import 'package:saudi_calender_task/services/home_widget_service.dart';
import 'package:saudi_calender_task/ui/pages/add_event/add_event_page.dart';
import 'package:saudi_calender_task/ui/pages/home/home_page.dart';
import 'package:saudi_calender_task/ui/pages/my_events/my_events_view.dart';

import '../../../core/local_service/local_notification_service.dart';
import '../../../core/mixins/share_app.dart';
import '../../../remote_service/event_service.dart';
import '../../../services/firebase_auth_service.dart';
import '../../widgets/home_app_bar.dart';
import '../auth/sign_in_page.dart';

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
      await ref.read(eventProvider.notifier).getEvents();
      await ref.read(localNotificationsServiceProvider).init(context);
      await ref
          .read(localNotificationsServiceProvider)
          .handleBackgroundNotification(
            context,
          );
      final events = ref.watch(eventProvider).events?.data;
      await HomeWidgetService.updateEventsWidget(events ?? []);
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
      floatingActionButton: currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: Color(0xff245D3A),
              shape: CircleBorder(),
              onPressed: () async {
                final isSignedIn = FirebaseAuthService().isSignedIn();
                if (isSignedIn) {
                  context.pushNamed(AddEditEventPage.routeName);
                } else {
                  context.pushNamed(SignInPage.routeName);
                }
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

List<Widget> screens = [
  HomePage(),
  MyEventsView(),
  const Center(child: Text("الأخبار")),
  const Center(child: Text("الاعدادات")),
  const Center(
      child: Text(
    "تطبيقاتنا",
  )),
];
