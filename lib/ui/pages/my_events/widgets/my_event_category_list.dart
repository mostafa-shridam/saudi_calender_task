
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:saudi_calender_task/providers/my_event_service.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../models/my_event.dart';

class MyEventCategoryList extends ConsumerWidget {
  const MyEventCategoryList({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 69,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 37,
            width: 37,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: graySwatch.shade200,
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.images.edit,
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 10),
          MyEventCategoryListItems(),
        ],
      ),
    );
  }
}

class MyEventCategoryListItems extends ConsumerStatefulWidget {
  const MyEventCategoryListItems({
    super.key,
  });

  @override
  ConsumerState<MyEventCategoryListItems> createState() =>
      _MyEventCategoryListItemsState();
}

class _MyEventCategoryListItemsState
    extends ConsumerState<MyEventCategoryListItems> {
  Future<void> init() async {
    await ref.read(myEventServiceProvider.notifier).getCategories();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(myEventServiceProvider).categories ??
        [
          MyEventCategory.fromJson(
              {"id": "0", "name": "عام", "color": graySwatch.shade400.toARGB32()}),
        ];
    // remove duplicates

    List<MyEventCategory> removeDuplicates({
      required List<MyEventCategory?> categories,
    }) {
      if (categories.isEmpty) {
        return [];
      }
      final List<MyEventCategory> uniqueCategories = [];
      for (final category in categories) {
        if (!uniqueCategories.contains(category)) {
          uniqueCategories.add(category!);
        }
      }
      return uniqueCategories;
    }

  List<MyEventCategory> uniqeCategory = removeDuplicates(categories: category);
    return Expanded(
      child: SizedBox(
        height: 37,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: uniqeCategory.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => setState(() {
                ref.read(myEventServiceProvider.notifier).changeCategory(
                      uniqeCategory[index],
                    );
                currentIndex = index;
              }),
              child: MyEventSelectItem(
                index: index,
                color: Color(uniqeCategory[index].color ?? graySwatch.toARGB32()),
                title: uniqeCategory[index].name ?? "",
                currentIndex: currentIndex,
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyEventSelectItem extends StatelessWidget {
  const MyEventSelectItem({
    super.key,
    required this.index,
    required this.color,
    required this.currentIndex,
    required this.title,
  });
  final int index, currentIndex;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return index == currentIndex
        ? Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: graySwatch.shade200),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          );
  }
}
