import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudi_calender_task/ui/pages/my_events/widgets/add_event_widget.dart';
import 'package:saudi_calender_task/ui/widgets/custom_divider.dart';
import 'package:saudi_calender_task/ui/widgets/send_gift.dart';
import 'package:saudi_calender_task/ui/widgets/today_date.dart';

import '../../../core/repos/auth_repo_impl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/my_event.dart';
import '../../../providers/my_event_provider.dart';
import 'widgets/my_event_category_list.dart';
import 'widgets/my_event_data.dart';

class MyEventsView extends ConsumerStatefulWidget {
  const MyEventsView({super.key});

  @override
  ConsumerState<MyEventsView> createState() => _MyEventsViewState();
}

class _MyEventsViewState extends ConsumerState<MyEventsView> {
  late bool isSignedIn;
  @override
  void initState() {
    super.initState();
    isSignedIn = ref.read(authRepoProvider).getUserDataLocal() != null;
    Future.microtask(() async {
      ref.read(myEventServiceProvider.notifier).startInternetListener();
      await ref.read(myEventServiceProvider.notifier).getMyEvents();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final myEvents = ref.watch(myEventServiceProvider).filterEvents ?? [];
    final isLoading = ref.watch(myEventServiceProvider).loading ?? false;
    return Builder(builder: (context) {
      if (isLoading && isSignedIn && myEvents.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SendGift(),
          TodayDate(
            color: Color(graySwatch.shade100.toARGB32()),
          ),
          if (myEvents.isEmpty) ...[
            SizedBox(height: 220),
            AddEventWidget(),
          ],
          if (myEvents.isNotEmpty) ...[
            MyEventCategoryList(),
            CustomDivider(thickness: 1),
            Flexible(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 60),
                separatorBuilder: (context, index) =>
                    CustomDivider(thickness: 1),
                itemCount: myEvents.length,
                itemBuilder: (context, index) {
                  return MyEventData(myEvent: myEvents[index] ?? MyEvent());
                },
              ),
            ),
          ],
        ],
      );
    });
  }
}
