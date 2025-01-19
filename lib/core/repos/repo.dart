import 'package:saudi_calender_task/models/category_model.dart';
import 'package:saudi_calender_task/models/event_model.dart';

class Repo {
  Future<void> saveEvents() async {}
  Events getEvents() {
    return Events();
  }

  EventModel getEvent(int? eventId) {
    return EventModel();
  }

  Future<void> saveEvent(int? eventId) async {}

  Future<void> saveCategories() async {}

  Categories getCategories() {
    return Categories();
  }
}
