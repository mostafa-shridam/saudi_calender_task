import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/enums/constants_enums.dart';
import 'package:saudi_calender_task/models/event_model.dart';
import 'local_storage.dart';

part 'generated/events_local_service.g.dart';

class EventsLocalService {
  void saveEvents(String events) {
    LocalStorage.instance.put(ConstantsEnums.eventsKey.name, events);
  }

  void saveEvent(String event, int? id) {
    LocalStorage.instance.put('${ConstantsEnums.eventKey.name}_$id', event);
  }

  Events? getEvents() {
    final String? events =
        LocalStorage.instance.get(ConstantsEnums.eventsKey.name);
    if (events == null) {
      return null;
    }
    return Events.fromJson(jsonDecode(events));
  }

  EventModel? getEvent(int? id) {
    final String? event =
        LocalStorage.instance.get('${ConstantsEnums.eventKey.name}_$id');
    if (event == null) {
      return null;
    }
    return EventModel.fromJson(jsonDecode(event));
  }
}

@Riverpod(keepAlive: true)
EventsLocalService eventsLocalService(Ref ref) {
  return EventsLocalService();
}
