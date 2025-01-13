import 'dart:convert';
import 'dart:developer';
import 'package:saudi_calender_task/core/local_service/events_local_service.dart';
import 'package:saudi_calender_task/core/local_service/local_categories_service.dart';
import '../../models/category_model.dart';
import '../../models/event_model.dart';
import '../../services/get_data_service.dart';
import '../../services/get_it_service.dart';
import 'event_repo.dart';

class EventRepoImpl implements EventRepo {
  final GetDataService getDataService = getIt.get<GetDataService>();
  final EventsLocalService eventsLocalService = EventsLocalService();
  final CategoriesLocalService categoriesLocalService = CategoriesLocalService();

  @override
  Future<void> saveEvents() async {
    final eventsData = await getDataService.getEvents();
    try {
      if (eventsData == null) {
        getEvent();
      }
      final saveEvents = eventsLocalService.saveEvents(jsonEncode(eventsData));
      return saveEvents;
    } catch (e) {
      getEvent();
      log(e.toString());
      throw Exception("Failed to save events: ${e.toString()}");
    }
  }

  @override
  Events getEvent() {
    try {
      final eventData = eventsLocalService.getEvents();
      if (eventData != null) {
        return eventData;
      } else {
        log("No events found in local storage.");
        throw Exception("No events found in local storage.");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("No events found in local storage.");
    }
  }

  @override
  Categories getCategories() {
    try {
      final categoriesData = categoriesLocalService.getCategories();
      if (categoriesData != null) {
        return categoriesData;
      } else {
        log("No categories found in local storage.");
        throw Exception("No categories found in local storage.");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("No categories found in local storage.");
    }
  }
  @override
  Future<void> saveCategories() async {
    final categoriesData = await getDataService.getCategories();
    try {
      if (categoriesData == null) {
        getCategories();
      }
      final saveCategories = categoriesLocalService.saveCategories(jsonEncode(categoriesData));
      return saveCategories;
    } catch (e) {
      getCategories();
      log(e.toString());
      throw Exception("Failed to save categories: ${e.toString()}");
    }
  }
}
