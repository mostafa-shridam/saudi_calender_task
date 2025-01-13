import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudi_calender_task/models/category_model.dart';
import 'package:saudi_calender_task/services/get_it_service.dart';

import '../core/repos/repo_impl.dart';

class CategoriesService extends StateNotifier<Categories> {
  final RepoImpl repo;

  CategoriesService(this.repo) : super(Categories());

  Future<void> getCategories() async {
    try {
      final events = repo.getCategories();
      if (events.data != null) {
        state = events;
      } else {
        log('No events data found.');
      }
    } catch (e, stackTrace) {
      log('Error getting events: $e', stackTrace: stackTrace);
    }
  }

  Future<void> saveCategories() async {
    try {
      await repo.saveCategories();
    } catch (e, stackTrace) {
      log('Error saving events: $e', stackTrace: stackTrace);
    }
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesService, Categories>((ref) {
  final categoriesNotifier = CategoriesService(getIt.get<RepoImpl>());
  categoriesNotifier.saveCategories().then((_) {
    categoriesNotifier.getCategories();
  });
  return categoriesNotifier;
});
