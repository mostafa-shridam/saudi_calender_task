import 'package:intl/intl.dart';

import '../core/constants/constants.dart';

class EventModel {
  String? id;
  String? title;
  String? hijriStartsAt;
  String? startsAt;
  String? remainingDays;
  String? eventDate;
  String? eventDay;
  String? eventDateAr;
  int? interval;
  Section? section;

  EventModel({
    this.id,
    this.title,
    this.hijriStartsAt,
    this.startsAt,
    this.remainingDays,
    this.eventDate,
    this.eventDay,
    this.eventDateAr,
    this.interval,
    this.section,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'].toString(),
      title: json['title'],
      hijriStartsAt: json['hijri_starts_at'],
      startsAt: json['starts_at'],
      remainingDays: json['remaining_days'],
      eventDate: json['event_date'],
      eventDay: json['event_day'],
      eventDateAr: json['event_date_ar'],
      interval: json['interval'],
      section:
          json['section'] != null ? Section.fromJson(json['section']) : null,
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
      'section': section?.toJson(),
    };
  }

  DateTime? get startsAtDateTime =>
      DateFormat(eventsDateFormat, 'en').tryParse(startsAt ?? '');

  DateTime? get endsAtDateTime =>
      DateFormat(eventsDateFormat, 'en').tryParse(eventDate ?? '');
  Map<String, dynamic> toWidgetJson(
      {required bool isAndroid}) {
    return {
      'eventId': id.toString(),
      'title': title,
      'eventDate': (isAndroid ? startsAtDateTime?.toLocal() : startsAtDateTime?.toUtc())?.toIso8601String(),
    };}
}

class Section {
  String? id;
  String? name;
  Category? category;

  Section({
    this.id,
    this.name,
    this.category,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'].toString(),
      name: json['name'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category?.toJson(),
    };
  }
}

class Category {
  String? id;
  String? name;
  int? sort;
  int? type;
  String? typeLabel;

  Category({
    this.id,
    this.name,
    this.sort,
    this.type,
    this.typeLabel,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'],
      sort: json['sort'],
      type: json['type'],
      typeLabel: json['type_label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sort': sort,
      'type': type,
      'type_label': typeLabel,
    };
  }
}

class Events {
  Events({this.data, this.status, this.hash});

  Events.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EventModel>[];
      json['data'].forEach((v) {
        data!.add(EventModel.fromJson(v));
      });
    }
    status = json['status'];
    hash = json['hash'];
  }
  List<EventModel>? data;
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
