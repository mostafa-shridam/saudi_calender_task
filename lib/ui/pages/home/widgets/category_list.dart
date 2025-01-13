import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_calender_task/models/category_model.dart';
import 'package:saudi_calender_task/remote_service/event_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../remote_service/categories_service.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
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
                Assets.images.arrowSwapHorizontal,
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 10),
          CategoryListItems(),
        ],
      ),
    );
  }
}

class CategoryListItems extends ConsumerStatefulWidget {
  const CategoryListItems({
    super.key,
  });
  @override
  ConsumerState<CategoryListItems> createState() => _CategoryListItemsState();
}

class _CategoryListItemsState extends ConsumerState<CategoryListItems> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    List<CategoryModel> removeDuplicates({
      required List<CategoryModel?> categories,
    }) {
      if (categories.isEmpty) {
        return [];
      }
      final List<CategoryModel> uniqueCategories = [];
      for (final category in categories) {
        if (!uniqueCategories.contains(category)) {
          uniqueCategories.add(category!);
        }
      }
      return uniqueCategories;
    }

    final List<CategoryModel> category = [
      CategoryModel(
        id: "0",
        name: "الكل",
        sort: 99,
        type: 99,
        typeLabel: "all",
      ),
    ];
    category.addAll(
      removeDuplicates(
        categories: categories.data ?? [],
      ),
    );

    return Expanded(
      child: SizedBox(
        height: 37,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: (context, index) {
            final selectedCategory = ref.watch(eventProvider).category;
            final isSelected = category[index].id == selectedCategory?.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });

                ref.read(eventProvider.notifier).changeCategory(category[index]);
              },
              child: CategoryItem(
                isSelected: isSelected,
                label: category[index].name ?? "",
                icon: Assets.images.calendar2,
                color: category[index].backgroundColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String icon;
  final int color;

  const CategoryItem({
    super.key,
    this.isSelected = false,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: !isSelected ? Border.all(color: graySwatch.shade200) : null,
        color: isSelected ? Color(color) : Colors.white,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xff000000).withAlpha(8),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: const Color(0xff000000).withAlpha(4),
                  blurRadius: 4,
                ),
              ]
            : null,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            SvgPicture.asset(icon,
                colorFilter: isSelected
                    ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : null),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
