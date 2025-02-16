import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ListTileCategory extends ConsumerWidget {
  const ListTileCategory({
    super.key,

    required this.categoryName,
    required this.title,
    this.onTap,
    this.color,
    required this.isSelectedCategory,
  });
  final String title;
  final String categoryName;
  final int? color;
  final bool isSelectedCategory;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widthSize = SizedBox(width: 12);
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal:12),
      tileColor: Colors.white,
      leading: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelectedCategory == true)
            CircleAvatar(
              backgroundColor: Color(color!),
              radius: 6,
            ),
          widthSize,
          Text(
            categoryName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          widthSize,
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
