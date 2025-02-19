import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudi_calender_task/models/my_event.dart';

import '../../core/theme/app_theme.dart';
import 'custom_divider.dart';
import '../pages/add_event/widgets/build_modal_bottom_sheet.dart';
import '../pages/add_event/widgets/category_list.dart';
import '../pages/add_event/widgets/list_tile_category.dart';
import '../pages/add_event/widgets/select_event_date.dart';

class CustomListTileCategoryItems extends ConsumerStatefulWidget {
  const CustomListTileCategoryItems({
    super.key,
    required this.alert,
    required this.repeat,
    required this.category,
    required this.categories,
    this.tap = true,
  });
  final MyEventCategory? categories;
  final bool tap;
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
    if (widget.categories != null) {
      categoryValue = widget.categories!.name ?? 'عام';
      id = widget.categories!.id ?? "0";
      color = widget.categories!.color ?? primaryColor.toARGB32();
    }
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
          isTaped: widget.tap,
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
          isTaped: widget.tap,
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
          isTaped: widget.tap,
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
              },
            );
          },
          color: color,
          isSelectedCategory: true,
          categoryName: categoryValue,
          title: 'التصنيف',
        ),
      ],
    );
  }
}
