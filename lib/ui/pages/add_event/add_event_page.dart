// ignore_for_file: use_build_context_synchronously

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:saudi_calender_task/core/extension/color.dart';
import 'package:saudi_calender_task/models/my_event.dart';

import '../../../constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/my_event_service.dart';
import '../../widgets/custom_show_snack_bar.dart';
import '../../widgets/custom_text_filed.dart';
import 'widgets/event_app_bar.dart';
import '../../widgets/custom_list_tile_category_items.dart';
import 'widgets/list_tile_category.dart';
import 'widgets/name_date.dart';

class AddEditEventPage extends ConsumerStatefulWidget {
  const AddEditEventPage({super.key, this.myEvent});
  static const String routeName = "/add_event_view";
  final MyEvent? myEvent;

  @override
  ConsumerState<AddEditEventPage> createState() => _AddEditEventPageState();
}

class _AddEditEventPageState extends ConsumerState<AddEditEventPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  String? startsAt, hijriStartsAt;
  String? eventDate, eventDay, eventDateAr;
  String? remainingDays;
  MyEventCategory? category;
  int? interval;
  String? id;
  int? color;

  @override
  void initState() {
    super.initState();
    if (widget.myEvent != null) {
      titleController.text = widget.myEvent!.title ?? "";
      startsAt = widget.myEvent!.startsAt;
      hijriStartsAt = widget.myEvent!.hijriStartsAt;
      eventDate = widget.myEvent!.eventDate;
      eventDay = widget.myEvent!.eventDay;
      eventDateAr = widget.myEvent!.eventDateAr;
      remainingDays = widget.myEvent!.remainingDays;
      category = widget.myEvent!.category;
      interval = widget.myEvent!.interval;
      id = widget.myEvent!.id;
      color = widget.myEvent!.color;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String defaultDate = "Select date";
    final dateFromModel = DateFormat(selectedDateFormat, "ar").format(
      DateTime.parse(
        widget.myEvent?.eventDate?.split(" ")[0] ?? DateTime.now().toString(),
      ),
    );
    return Form(
      key: formKey,
      child: LoaderOverlay(
        overlayWholeScreen: true,
        child: Scaffold(
          backgroundColor: const Color(0xffF1F5F9),
          appBar: eventAppBar(
            textButton: widget.myEvent != null ? "تعديل" : "إضافة",
            title: widget.myEvent != null ? "تعديل" : "إضافة مناسبة",
            context: context,
            onTap: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                if (eventDate == null || eventDate == defaultDate) {
                  customShowSnackBar(context,
                      message: "برجاء اختيار تاريخ البداية");
                  return;
                }
                context.loaderOverlay.show();
                final event = MyEvent(
                  id: id ?? "",
                  title: titleController.text,
                  hijriStartsAt: hijriStartsAt ?? defaultDate,
                  startsAt: startsAt ?? defaultDate,
                  remainingDays: remainingDays ?? defaultDate,
                  eventDate: eventDate ?? defaultDate,
                  eventDay: eventDay ?? defaultDate,
                  eventDateAr: eventDateAr ?? defaultDate,
                  interval: interval ?? 0,
                  category: category ?? MyEventCategory(id: "0", name: "عام"),
                  color: color ?? primaryColor.toARGB32,
                );

                bool? result;
                MyEvent? myEvent;
                if (widget.myEvent != null) {
                  myEvent = await ref
                      .watch(myEventServiceProvider.notifier)
                      .editEvent(event);
                      widget.myEvent?.title = event.title;
                      widget.myEvent?.startsAt = event.startsAt;
                      widget.myEvent?.eventDate = event.eventDate;
                } else {
                  result = await ref
                      .read(myEventServiceProvider.notifier)
                      .addEvent(event);
                }

                context.loaderOverlay.hide();
                if (result != null || myEvent != null) {
                  context.pop();
                } else {
                  customShowSnackBar(context, message: "حدث خطأ أثناء العملية");
                }
              }
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                CustomTextField(
                  controller: titleController,
                  hint: "عنوان المناسبة",
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) =>
                      value!.isEmpty ? "برجاء ادخال عنوان المناسبة" : null,
                ),
                const SizedBox(height: 24),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTileCategory(
                        categoryName: "ميلادي",
                        title: "نوع التاريخ",
                        isSelectedCategory: false,
                        onTap: () {},
                      ),
                      DateWidget(
                        nameDate: "التاريخ",
                        startsAt: (value) => startsAt = value,
                        eventDate: (value) => eventDate = value,
                        date: widget.myEvent != null ? dateFromModel : null,
                        time: widget.myEvent?.startsAt,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ExpandableNotifier(
                  child: ExpandablePanel(
                    header: Container(
                      color: Colors.white,
                      height: 48,
                      child: Center(child: Text("خيارات متقدمة")),
                    ),
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                      tapBodyToExpand: true,
                      hasIcon: false,
                    ),
                    expanded: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: CustomListTileCategoryItems(
                            alert: (value) =>
                                setState(() => remainingDays = value),
                            repeat: (value) =>
                                setState(() => remainingDays = value),
                            category: (value) =>
                                setState(() => category = value),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: detailsController,
                          hint: "تفاصيل المناسبة",
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                        ),
                      ],
                    ),
                    collapsed: Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
