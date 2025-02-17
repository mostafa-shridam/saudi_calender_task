import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/core/mixins/share_app.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../models/my_event.dart';
import '../../../../providers/my_event_provider.dart';
import '../../../widgets/share_object.dart';
import '../../add_event/add_event_page.dart';

class BottomRowForMyEventDetails extends ConsumerWidget with ShareMixin {
  const BottomRowForMyEventDetails({super.key, required this.myEvent});
  final MyEvent myEvent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ShareObject(
          onTapDown: (details) {
            whatsAppMessage(
                text: "$kShareAppName\n$kShareAppUrl\n${myEvent.title}");
          },
          icon: Assets.images.whatsapp,
          label: "واتساب",
          width: 90,
        ),
        ShareObject(
          onTapDown: (details) {
            shareApp(
              context,
              details.globalPosition.dx,
              details.globalPosition.dy,
              text: "$kShareAppName\n$kShareAppUrl\n${myEvent.title}",
            );
          },
          icon: Assets.images.export,
          label: "مشاركة",
          width: 90,
        ),
        ShareObject(
          onTapDown: (details) {
            context.pushNamed(AddEditEventPage.routeName, extra: myEvent);
          },
          icon: Assets.images.edit,
          label: "تعديل",
          width: 90,
        ),
        ShareObject(
          onTap: () async {
            final result = await ref
                .read(myEventServiceProvider.notifier)
                .deleteEvent(myEvent);
            if (result) {
              // ignore: use_build_context_synchronously
              context.pop();
            }
          },
          icon: Assets.images.trash,
          label: "حذف",
          width: 90,
          color: Colors.red,
        ),
      ],
    );
  }
}
