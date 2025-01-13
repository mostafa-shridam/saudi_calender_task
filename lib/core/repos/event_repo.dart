import 'package:saudi_calender_task/models/category_model.dart';
import 'package:saudi_calender_task/models/event_model.dart';

class EventRepo {
  Future<void> saveEvents() async {}
  Events getEvent() {
    return Events();
  }
  Future<void> saveCategories() async {}

  Categories getCategories() {
    return Categories();
  }
}
