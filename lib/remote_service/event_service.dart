import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudi_calender_task/models/category_model.dart';

import '../core/repos/event_repo_impl.dart';
import '../models/event_model.dart';
import '../services/get_it_service.dart';

class EventRiverpod extends StateNotifier<EventState> {
  final EventRepoImpl repo;

  EventRiverpod(this.repo)
      : super(
          EventState(
            category: CategoryModel(
              id: "0",
              name: "الكل",
              sort: 99,
              type: 99,
              typeLabel: "all",
            ),
          ),
        );

  Future<void> getEvents() async {
    final DateTime now = DateTime.now();
    state = state.copyWith();
    try {
      final events = repo.getEvent();
      if (events.data != null && events.data!.isNotEmpty) {
        //filter date
        events.data?.removeWhere((element) => element.eventDate == null ? false : DateTime.parse(element.eventDate!.split(" ")[0]).isBefore(now));
        events.data
            ?.sort((a, b) => a.eventDate?.compareTo(b.eventDate ?? '') ?? 0);
        state.events = events;
      } else {
        log('No events data found.');
      }
      state = state.copyWith();
    } catch (e, stackTrace) {
      log('Error getting events: $e', stackTrace: stackTrace);
    }
  }

  Future<void> saveEvents() async {
    try {
      await repo.saveEvents();
    } catch (e, stackTrace) {
      log('Error saving events: $e', stackTrace: stackTrace);
    }
  }

  // change category
  void changeCategory(CategoryModel category) {
    log('Changing category to: ${category.name}');

    state = state.copyWith(category: category);
  }
}

final eventProvider = StateNotifierProvider<EventRiverpod, EventState>((ref) {
  final eventNotifier = EventRiverpod(getIt.get<EventRepoImpl>());
  eventNotifier.saveEvents().then((_) {
    eventNotifier.getEvents();
  });
  return eventNotifier;
});

class EventState {
  Events? events;
  bool? isLoading;
  CategoryModel? category;

  List<EventModel> get fliteredList {
    if(category?.id == '0') return events?.data ?? [];
    return events?.data?.where((element) {
      log('element.section?.category?.id ${ category?.id}');
          return element.section?.category?.id == category?.id;
        }).toList() ??
        [];
  }

  EventState({this.events, this.isLoading, this.category});

  EventState copyWith(
      {Events? events, bool? isLoading, CategoryModel? category}) {
    return EventState(
        events: events ?? this.events,
        isLoading: isLoading ?? this.isLoading,
        category: category ?? this.category);
  }
}
