import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/extension/color.dart';
import 'package:saudi_calender_task/services/firebase_auth_service.dart';
import 'package:saudi_calender_task/ui/pages/add_event/add_event_page.dart';
import 'package:saudi_calender_task/ui/pages/auth/sign_in_page.dart';
import 'package:saudi_calender_task/ui/widgets/custom_divider.dart';
import 'package:saudi_calender_task/ui/widgets/send_gift.dart';
import 'package:saudi_calender_task/ui/widgets/today_date.dart';

import '../../../core/theme/app_theme.dart';
import '../../../models/my_event.dart';
import '../../../providers/my_event_service.dart';
import 'widgets/my_event_category_list.dart';
import 'widgets/my_event_data.dart';

class MyEventsView extends ConsumerStatefulWidget {
  const MyEventsView({super.key});

  @override
  ConsumerState<MyEventsView> createState() => _MyEventsViewState();
}

class _MyEventsViewState extends ConsumerState<MyEventsView> {
  Future<void> init() async {
    await ref.read(myEventServiceProvider.notifier).getMyEvents();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      init();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final myEvents = ref.watch(myEventServiceProvider).events ?? [];
    final isLoading = ref.watch(myEventServiceProvider).loading;

    return Builder(builder: (context) {
      if (isLoading && FirebaseAuthService().isSignedIn() && myEvents.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      log("myEvents: ${myEvents.length}");
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SendGift(),
          TodayDate(
            color: Color(graySwatch.shade100.toARGB32),
          ),
          MyEventCategoryList(),
          CustomDivider(thickness: 1),
          if (myEvents.isEmpty) ...[
            SizedBox(height: 180),
            AddEventWidget(),
          ],
          if (myEvents.isNotEmpty) ...[
            Flexible(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    CustomDivider(thickness: 1),
                itemCount: myEvents.length,
                itemBuilder: (context, index) {
                  return MyEventData(myEvent: myEvents[index] ?? MyEvent());
                },
              ),
            ),
          ]
        ],
      );
    });
  }
}

class AddEventWidget extends ConsumerWidget {
  const AddEventWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 335,
      height: 178,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: graySwatch.shade50,
        border: Border.all(color: graySwatch.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "لا توجد مناسبات",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "عذرا, لم تقم بإضافة اي مناسبات حتى الان!\nقم بإضافة اول مناسبة",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(graySwatch.shade200),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                final isSignedIn = FirebaseAuthService().isSignedIn();
                if (isSignedIn) {
                  context.pushNamed(AddEditEventPage.routeName);
                } else {
                  context.pushNamed(SignInPage.routeName);
                }
              },
              child: Text(
                "إضافة مناسبة",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
