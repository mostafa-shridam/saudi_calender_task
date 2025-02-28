import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:home_widget/home_widget.dart';
import 'package:saudi_calender_task/models/event_model.dart';

import '../core/constants/constants.dart';


class HomeWidgetService {
  factory HomeWidgetService() {
    return _singleton;
  }

  HomeWidgetService._internal();
  static final HomeWidgetService _singleton = HomeWidgetService._internal();

  Future<void> init() async {
    await HomeWidget.setAppGroupId(appGroupId);
  }

  static Future<void> sendAndUpdate({
    required bool isDarkMode,
  }) async {
    try {
      Future.wait([
        HomeWidget.updateWidget(
          name: 'HomeWidget',
          androidName: androidWidgetName,
          iOSName: iosWidgetName,
        ),
      ]);
    } catch (e) {
      log('Error Sending Data. $e');
    }
  }

  static Future<void> updateEventsWidget(
    List<EventModel?> events,
  ) async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      List<Map<String, dynamic>> eventsJson;
      final bool isAndroid = Platform.isAndroid;
      eventsJson = [
        ...events.map(
            (e) => (e?.toWidgetJson(isAndroid: isAndroid) ?? {})),
      ];
      eventsJson.sort((a, b) {
        if (a['eventDate'] == null || b['eventDate'] == null) return 0;
        final aEventDate = DateTime.parse(a['eventDate']);
        final bEventDate = DateTime.parse(b['eventDate']);
        return aEventDate.compareTo(bEventDate);
      });
      await Future.wait([
        HomeWidget.saveWidgetData<String>('events', jsonEncode(eventsJson)),

      ]);
      await HomeWidget.updateWidget(
        name: 'LastEventsWidget',
        androidName: androidWidgetName,
        iOSName: iosWidgetName,
      );
      log("Success Sending Data");
    } catch (e, s) {
      log('Error Sending Data. $e, Stack $s');
    }
  }
}
