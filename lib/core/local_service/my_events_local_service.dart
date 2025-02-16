import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/my_event.dart';
import '../enums/constants_enums.dart';
import 'local_storage.dart';

part 'generated/my_events_local_service.g.dart';

class MyEventsLocalService {
  void saveMyEvents(String myEvents) {
    LocalStorage.instance.put(ConstantsEnums.myEventsKey.name, myEvents);
  }

  void saveMyEvent(String myEvent, String id) {
    LocalStorage.instance.put('${ConstantsEnums.myEventKey.name}_$id', myEvent);
  }

  MyEvents? getMyEvents() {
    final myEvents = LocalStorage.instance.get(ConstantsEnums.myEventsKey.name);
    if (myEvents == null) {
      return null;
    }
    return MyEvents.fromJson(jsonDecode(myEvents));
  }

  MyEvent? getMyEvent(int? id) {
    final String? myEvent =
        LocalStorage.instance.get('${ConstantsEnums.myEventKey.name}_$id');
    if (myEvent == null) {
      return null;
    }
    return MyEvent.fromJson(jsonDecode(myEvent));
  }
}

@Riverpod(keepAlive: true)
MyEventsLocalService myEventsLocalService(Ref ref) {
  return MyEventsLocalService();
}
