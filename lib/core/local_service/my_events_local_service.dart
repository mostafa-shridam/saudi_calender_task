import 'dart:convert';
import 'dart:developer';

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

  void saveCategories(String category) {
    LocalStorage.instance.put(ConstantsEnums.myCategoryKey.name, category);
  }

  MyEventCategory? getCategories() {
    final String? category =
        LocalStorage.instance.get(ConstantsEnums.myCategoryKey.name);
    if (category == null) {
      return null;
    }
    return MyEventCategory.fromJson(jsonDecode(category));
  }

dynamic getMyEvents() {
  final myEvents = LocalStorage.instance.get(ConstantsEnums.myEventsKey.name);

  if (myEvents == null) {
    return null;
  }

  final decodedData = jsonDecode(myEvents);

  if (decodedData is Map<String, dynamic>) {
    return MyEvents.fromJson(decodedData);
  } else if (decodedData is List) {
    return decodedData.map((e) => MyEvent.fromJson(e as Map<String, dynamic>)).toList();
  } else {
    log("Error: Unexpected data type: ${decodedData.runtimeType}");
    return null;
  }
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
