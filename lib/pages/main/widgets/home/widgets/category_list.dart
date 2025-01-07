import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/services/app_theme.dart';
import '../../../../../gen/assets.gen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

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
          const CategoryListItems(),
        ],
      ),
    );
  }
}

class CategoryListItems extends StatefulWidget {
  const CategoryListItems({super.key});

  @override
  State<CategoryListItems> createState() => _CategoryListItemsState();
}

class _CategoryListItemsState extends State<CategoryListItems> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 37,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            final isSelected = index == currentIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: CategoryItem(
                isSelected: isSelected,
                label: labels[index],
                icon: icons[index],
                color: colors[index],
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

List<int> colors = [
  0xff245D3A,
  0xff266EF1,
  0xff944DE7,
  0xffF6BC2F,
];

List<String> labels = [
  "الكل",
  "المناسبات",
  "الرواتب",
  "الدراسة",
];

List<String> icons = [
  Assets.images.archive,
  Assets.images.calendar2,
  Assets.images.moneys,
  Assets.images.book,
];
