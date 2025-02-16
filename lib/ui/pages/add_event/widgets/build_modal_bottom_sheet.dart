import 'package:flutter/material.dart';

import 'category_list.dart';

void buildModalBottomSheet({
  required BuildContext context,
  required ValueChanged<String> selectedCategory,
  required ValueChanged<Color> selectedColor,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) {
      return ListView.builder(
        itemCount: CategoryList.categoryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              CategoryList.categoryList[index].toString(),
            ),
            trailing: CircleAvatar(
              radius: 12,
              backgroundColor: CategoryList.colorList[index],
            ),
            onTap: () {
              selectedCategory(CategoryList.categoryList[index]);
              selectedColor(CategoryList.colorList[index]);
              Navigator.pop(context);
            },
          );
        },
      );
    },
  );
}

void customModalBottomSheet({
  required BuildContext context,
  required ValueChanged<String> isSelcected,
  required List title,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) {
      return ListView.builder(
        itemCount: title.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Center(
              child: Text(
                title[index].toString(),
              ),
            ),
            onTap: () {
              isSelcected(title[index]);
              Navigator.pop(context);
            },
          );
        },
      );
    },
  );
}
