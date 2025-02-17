import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saudi_calender_task/models/my_event.dart';

import 'category_list.dart';

void buildModalBottomSheet({
  required BuildContext context,
  required ValueChanged<MyEventCategory> selectedCategory,
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
              selectedCategory(
                MyEventCategory(
                  id: index.toString(),
                  name: CategoryList.categoryList[index].toString(),
                  color: CategoryList.colorList[index].toARGB32(),
                ),
              );

              context.pop();
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
