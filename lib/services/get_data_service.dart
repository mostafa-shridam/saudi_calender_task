import 'dart:convert';
import 'dart:developer';
import 'package:saudi_calender_task/core/local_service/local_categories_service.dart';
import 'package:saudi_calender_task/models/category_model.dart';
import 'package:saudi_calender_task/models/event_model.dart';

import '../constants.dart';
import '../core/local_service/events_local_service.dart';
import 'dio_service.dart';
import 'get_it_service.dart';

class GetDataService {
  final DioService dioService;
  GetDataService() : dioService = getIt.get<DioService>();
  EventsLocalService eventsLocalService = EventsLocalService();
  CategoriesLocalService categoriesLocalService = CategoriesLocalService();
  Future<Events?> getEvents() async {
    try {
      final events = await dioService.get(
        '$eventsEndPoint?page=0&limit=0',
        withToken: false,
      );

      if (events == null) {
        final localEvents = eventsLocalService.getEvents();
        if (localEvents == null) {
          log('No events found in local storage.');
          return null;
        }
        return localEvents;
      }
      eventsLocalService.saveEvents(jsonEncode(events));
      return Events.fromJson(events);
    } catch (e) {
      log('Error getting Events: $e');
      return eventsLocalService.getEvents();
    }
  }

  Future<EventModel?> getEvent(int? eventId) async {
    try {
      final event = await dioService.get(
        '$eventsEndPoint/$eventId?page=0&limit=0',
        withToken: false,
      );
      if (event == null) {
        final localEvent = eventsLocalService.getEvent(eventId);
        if (localEvent == null) {
          log('No events found in local storage.');
          return null;
        }
        log('Events in local storage: $localEvent');

        return localEvent;
      }
      eventsLocalService.saveEvent(jsonEncode(event), eventId);
      return EventModel.fromJson(event['data'] ?? {});
    } catch (e) {
      log('Error getting Events: $e');
      return eventsLocalService.getEvent(eventId);
    }
  }

  Future<Categories?> getCategories() async {
    try {
      final categories = await dioService.get(
        categriesBaseUrl,
        withToken: false,
      );
      if (categories == null) {
        final localCategories = categoriesLocalService.getCategories();
        if (localCategories == null) {
          log('No categories found in local storage.');
          return null;
        }
        return localCategories;
      }
      categoriesLocalService.saveCategories(jsonEncode(categories));
      return Categories.fromJson(categories);
    } catch (e) {
      log('Error getting categories: $e');
      return categoriesLocalService.getCategories()!;
    }
  }
}
