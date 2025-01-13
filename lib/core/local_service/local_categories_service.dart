import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/enums/constants_enums.dart';
import 'package:saudi_calender_task/models/category_model.dart';
import 'local_storage.dart';

part 'generated/local_categories_service.g.dart';

class CategoriesLocalService {
  void saveCategories(String category) {
    LocalStorage.instance.put(ConstantsEnums.categoryKey.name, category);
  }

  void saveCategory(String category, int? id) {
    LocalStorage.instance.put('${ConstantsEnums.categoryKey.name}_$id', category);
  }

  Categories? getCategories() {
    final String? category =
        LocalStorage.instance.get(ConstantsEnums.categoryKey.name);
    if (category == null) {
      return null;
    }
    return Categories.fromJson(jsonDecode(category));
  }

  CategoryModel? getCategory(int? id) {
    final String? event =
        LocalStorage.instance.get('${ConstantsEnums.categoryKey.name}_$id');
    if (event == null) {
      return null;
    }
    return CategoryModel.fromJson(jsonDecode(event));
  }
}

@Riverpod(keepAlive: true)
CategoriesLocalService categoryLocalService(Ref ref) {
  return CategoriesLocalService();
}
