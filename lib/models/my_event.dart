import 'package:intl/intl.dart';

import '../constants.dart';

class MyEvent {
  String? id;
  String? title;
  String? hijriStartsAt;
  String? startsAt;
  String? remainingDays;
  String? eventDate;
  String? eventDay;
  String? eventDateAr;
  int? interval;
  MyEventCategory? category;
  int? color;

  MyEvent({
    this.id,
    this.title,
    this.hijriStartsAt,
    this.startsAt,
    this.remainingDays,
    this.eventDate,
    this.eventDay,
    this.eventDateAr,
    this.interval,
    this.category,
    this.color,
  });

  factory MyEvent.fromJson(Map<String, dynamic> json) {
    return MyEvent(
      id: json['id'].toString(),
      title: json['title'],
      hijriStartsAt: json['hijri_starts_at'],
      startsAt: json['starts_at'],
      remainingDays: json['remaining_days'],
      eventDate: json['event_date'],
      eventDay: json['event_day'],
      eventDateAr: json['event_date_ar'],
      interval: json['interval'],
      category: json['category'] != null
          ? MyEventCategory.fromJson(json['category'])
          : null,
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'hijri_starts_at': hijriStartsAt,
      'starts_at': startsAt,
      'remaining_days': remainingDays,
      'event_date': eventDate,
      'event_day': eventDay,
      'event_date_ar': eventDateAr,
      'interval': interval,
      'category': category?.toJson(),
      'color': color,
    };
  }

  DateTime? get startsAtDateTime =>
      DateFormat(eventsDateFormat, 'en').tryParse(startsAt ?? '');

  DateTime? get endsAtDateTime =>
      DateFormat(eventsDateFormat, 'en').tryParse(eventDate ?? '');
  Map<String, dynamic> toWidgetJson({required bool isAndroid}) {
    return {
      'eventId': id.toString(),
      'title': title,
      'eventDate':
          (isAndroid ? startsAtDateTime?.toLocal() : startsAtDateTime?.toUtc())
              ?.toIso8601String(),
    };
  }
}

class MyEventCategory {
  String? id;
  String? name;

  MyEventCategory({
    this.id,
    this.name,
  });

  factory MyEventCategory.fromJson(Map<String, dynamic> json) {
    return MyEventCategory(
      id: json['id'].toString(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class MyEvents {
  MyEvents({this.data, this.status, this.hash});

  MyEvents.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyEvent>[];
      json['data'].forEach((v) {
        data!.add(MyEvent.fromJson(v));
      });
    }
    status = json['status'];
    hash = json['hash'];
  }
  List<MyEvent>? data;
  int? status;
  String? hash;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['hash'] = hash;
    return data;
  }
}
