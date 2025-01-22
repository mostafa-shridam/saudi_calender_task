import 'dart:convert';
import 'dart:developer';
import 'package:saudi_calender_task/core/local_service/events_local_service.dart';
import 'package:saudi_calender_task/core/local_service/local_categories_service.dart';
import '../../models/category_model.dart';
import '../../models/event_model.dart';
import '../../services/get_data_service.dart';
import '../../services/get_it_service.dart';
import 'repo.dart';

class RepoImpl implements Repo {
  final GetDataService getDataService = getIt.get<GetDataService>();
  final EventsLocalService eventsLocalService = EventsLocalService();
  final CategoriesLocalService categoriesLocalService =
      CategoriesLocalService();

  @override
  Future<void> saveEvents() async {
    final eventsData = await getDataService.getEvents();
    try {
      if (eventsData == null ) {
        log("No events data retrieved from the API.");
        throw Exception("No events data available.");
      }
      final saveEvents =  eventsLocalService.saveEvents(jsonEncode(eventsData));
      return saveEvents;
    } catch (e) {
      log("Error saving events: ${e.toString()}");
    }
  }

  @override
  Events getEvents() {
    try {
      final eventData = eventsLocalService.getEvents();
      if (eventData != null) {
        return eventData;
      } else {
        log("No events found in local storage.");
        return Events(data: []);
      }
    } catch (e) {
      log("Error fetching events: ${e.toString()}");
      return Events(data: []);
    }
  }

  @override
  Future<void> saveEvent(int? eventId) async {
    final eventsData = await getDataService.getEvent(eventId);
    try {
      if (eventsData == null) {
        log("No event data retrieved for eventId: $eventId");
        throw Exception("No event data available for eventId: $eventId");
      }
      final saveEvents =  eventsLocalService.saveEvent(jsonEncode(eventsData), eventId);
      return saveEvents;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to save event: ${e.toString()}");
    }
  }

  @override
  EventModel getEvent(int? eventId) {
    try {
      final event = eventsLocalService.getEvent(eventId);
      if (event != null) {
        return event;
      } else {
        saveEvent(eventId);
        log("Event with ID $eventId not found.");
        throw Exception("Event with ID $eventId not found.");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Error fetching event.");
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
      throw Exception("Error fetching categories.");
    }
  }

  @override
  Future<void> saveCategories() async {
    final categoriesData = await getDataService.getCategories();
    try {
      if (categoriesData == null) {
        log("No categories data retrieved from the API.");
        throw Exception("No categories data available.");
      }
      final saveCategories =  categoriesLocalService.saveCategories(jsonEncode(categoriesData));
      return saveCategories;
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to save categories: ${e.toString()}");
    }
  }
}
