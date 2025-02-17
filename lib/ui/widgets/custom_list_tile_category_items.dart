import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudi_calender_task/models/my_event.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/my_event_service.dart';
import 'custom_divider.dart';
import '../pages/add_event/widgets/build_modal_bottom_sheet.dart';
import '../pages/add_event/widgets/category_list.dart';
import '../pages/add_event/widgets/list_tile_category.dart';
import '../pages/add_event/widgets/select_event_date.dart';

// مزود حالة التصنيفات
final myCategoryProvider = StateProvider<List<MyEventCategory>>((ref) => [
      MyEventCategory(
        id: "0",
        name: 'عام',
        color: primaryColor.toARGB32(),
      )
    ]);

final colorProvider = StateProvider<int>((ref) => primaryColor.toARGB32());

class CustomListTileCategoryItems extends ConsumerStatefulWidget {
  const CustomListTileCategoryItems({
    super.key,
    required this.alert,
    required this.repeat,
    required this.category,
    required this.categories,
  });
  final MyEventCategory? categories;

  final ValueChanged<String> alert, repeat;
  final ValueChanged<MyEventCategory> category;

  @override
  ConsumerState<CustomListTileCategoryItems> createState() =>
      _CustomListTileCategoryItemsState();
}

class _CustomListTileCategoryItemsState
    extends ConsumerState<CustomListTileCategoryItems> {
  TimeOfDay? timeValue;
  late String repeatValue;
  late String categoryValue, id;
  late int color;

  @override
  void initState() {
    super.initState();
    repeatValue = 'أبدًا';
    categoryValue = 'عام';
    id = "0";
    color = primaryColor.toARGB32();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileCategory(
          onTap: () async {
            final time = await selectTime(
              context: context,
              isSelectedTime: timeValue ?? TimeOfDay.now(),
            );
            if (time != null) {
              // ignore: use_build_context_synchronously
              widget.alert(time.format(context));
              if (mounted) {
                setState(() => timeValue = time);
              }
            }
          },
          isSelectedCategory: false,
          categoryName: timeValue?.format(context) ?? "في الموعد",
          title: 'التنبيه',
        ),
        const CustomDivider(thickness: 1),
        ListTileCategory(
          onTap: () {
            customModalBottomSheet(
              context: context,
              isSelcected: (value) {
                if (mounted) {
                  setState(() => repeatValue = value);
                }
                widget.repeat(value);
              },
              title: RepeatList.repeatList,
            );
          },
          isSelectedCategory: false,
          categoryName: repeatValue,
          title: 'التكرار',
        ),
        const CustomDivider(thickness: 1),
        ListTileCategory(
          onTap: () {
            buildModalBottomSheet(
              context: context,
              selectedCategory: (value) async {
                if (mounted) {
                  setState(() {
                    categoryValue = value.name!;
                    color = value.color!;
                    id = value.id!;
                  });
                }
                widget.category(value);
                await ref
                    .read(myEventServiceProvider.notifier)
                    .saveCategories(value);
              },
            );
          },
          color: widget.categories != null ? widget.categories!.color : color,
          isSelectedCategory: true,
          categoryName: widget.categories != null
              ? widget.categories!.name!
              : categoryValue,
          title: 'التصنيف',
        ),
      ],
    );
  }
}
