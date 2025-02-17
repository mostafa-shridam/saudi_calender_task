import 'dart:convert';
import 'dart:developer';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/constants/backend_endpoint.dart';
import 'package:saudi_calender_task/services/firestore_services.dart';
import 'package:uuid/uuid.dart';
import '../core/local_service/my_events_local_service.dart';
import '../models/my_event.dart';

part 'generated/my_event_service.g.dart';

@Riverpod(keepAlive: true)
class MyEventService extends _$MyEventService {
  late final MyEventsLocalService _myEventsLocalService;
  late final FireStoreService _firebaseFirestore;
  final Uuid _uuid = Uuid();

  @override
  MyEventState build() {
    _myEventsLocalService = ref.read(myEventsLocalServiceProvider);
    _firebaseFirestore = ref.read(fireStoreServiceProvider);
    return MyEventState();
  }

  Future<bool> addEvent(MyEvent event) async {
    state = state.copyWith(loading: true);
    event.id = _uuid.v4();
    event.isSynced = false;

    final internetAvailable = await InternetConnection().hasInternetAccess;

    if (internetAvailable) {
      MyEvent? result = await _firebaseFirestore.addEvents(
        path: BackendEndpoint.addEvent,
        data: event.toJson(),
        documentId: event.id ?? "",
      );

      if (result != null) {
        result.isSynced = true;
        final updatedEvents = [...?state.events, result];

        state = state.copyWith(
          loading: false,
          currentEvent: result,
          events: updatedEvents,
        );

        _myEventsLocalService.saveMyEvents(
            jsonEncode(updatedEvents.map((e) => e?.toJson()).toList()));

        return true;
      }
    } else {
      final localResult = await addLocalEvent(event);
      if (localResult != null) {
        final updatedEvents = [...?state.events, localResult];

        state = state.copyWith(
          loading: false,
          currentEvent: localResult,
          events: updatedEvents,
        );

        _myEventsLocalService.saveMyEvents(
            jsonEncode(updatedEvents.map((e) => e?.toJson()).toList()));

        return true;
      }
    }

    state = state.copyWith(loading: false);
    return false;
  }

  Future<MyEvent?> editEvent(MyEvent event) async {
    if (event.id?.isEmpty ?? true) {
      log("Error: Event ID is missing");
      return null;
    }
    state = state.copyWith(loading: true);
    try {
      final result = await _firebaseFirestore.editEvent(
        path: BackendEndpoint.getEvent,
        data: event.toJson(),
        documentId: event.id ?? "",
      );

      if (result != null) {
        final updatedEvents =
            state.events?.map((e) => e?.id == event.id ? event : e).toList();
        state = state.copyWith(
          loading: false,
          currentEvent: event,
          events: updatedEvents,
        );
        _myEventsLocalService.saveMyEvents(jsonEncode(updatedEvents));
      }
      return result;
    } catch (e) {
      log("Error editing event: $e");
      state = state.copyWith(loading: false);
      return null;
    }
  }

  Future<bool> deleteEvent(MyEvent event) async {
    final internetAvailable = await InternetConnection().hasInternetAccess;
    if (event.id?.isEmpty ?? true) {
      log("Error: Event ID is missing");
      return false;
    }

    state = state.copyWith(loading: true);
    try {
      final result = internetAvailable
          ? await _firebaseFirestore.deleteEvent(
              path: BackendEndpoint.getEvent,
              documentId: event.id!,
              data: event.toJson(),
            )
          : await deleteLocalEvent(event);
      final deleted = state.events?.where((e) => e?.id != event.id).toList();

      state = state.copyWith(
        loading: false,
        events: deleted,
        currentEvent: null,
      );
      _myEventsLocalService.saveMyEvents(jsonEncode(deleted));
      return result;
    } catch (e) {
      log("Error deleting event: $e");
      state = state.copyWith(loading: false);
      return false;
    }
  }

  Future<void> getMyEvents() async {
    state = state.copyWith(loading: true);

    final localEvents = _myEventsLocalService.getMyEvents() as List<MyEvent>?;
    if (localEvents != null && localEvents.isNotEmpty) {
      state = state.copyWith(events: localEvents, loading: false);
    }

    final internetAvailable = await InternetConnection().hasInternetAccess;
    if (internetAvailable) {
      final events = await _firebaseFirestore.getEvents(
        path: BackendEndpoint.getEvent,
      );

      if (events != null) {
        state = state.copyWith(
          events: events.data
            ?..sort((a, b) => a.eventDate?.compareTo(b.eventDate ?? '') ?? 0),
          loading: false,
        );

        _myEventsLocalService.saveMyEvents(jsonEncode(state.events));
      }
    } else {
      state = state.copyWith(loading: false);
    }
  }

  Future<MyEvent?> addLocalEvent(MyEvent event) async {
    state = state.copyWith(loading: true);
    event.id = _uuid.v4();

    try {
      event.isSynced = false;
      [...?state.events, event];

      state = state.copyWith(
        loading: false,
        currentEvent: event,
      );

      _myEventsLocalService.saveMyEvents(jsonEncode(event));
      return event;
    } catch (e) {
      state = state.copyWith(loading: false);

      return null;
    }
  }

  Future<bool> deleteLocalEvent(MyEvent event) async {
    state = state.copyWith(loading: true);
    try {
      final updatedEvents =
          state.events?.where((e) => e?.id != event.id).toList();

      _myEventsLocalService.saveMyEvents(jsonEncode(updatedEvents));

      state = state.copyWith(events: updatedEvents, loading: false);

      return true;
    } catch (e) {
      log("Error deleting local event: $e");
      state = state.copyWith(loading: false);
      return false;
    }
  }

  Future<void> syncLocalEvents() async {
    final internetAvailable = await InternetConnection().hasInternetAccess;
    if (!internetAvailable) return;
    final unsyncedEvents =
        state.events?.where((e) => e?.isSynced == false).toList() ?? [];

    if (unsyncedEvents.isEmpty) return;
    log("Syncing event: ${unsyncedEvents.first?.title}");

    for (final event in unsyncedEvents) {
      state = state.copyWith(loading: true);
      log("Syncing event: ${event?.title}");
      final result = await _firebaseFirestore.addEvents(
        path: BackendEndpoint.addEvent,
        data: event!.toJson(),
        documentId: event.id ?? "",
      );
      if (result != null) {
        event.isSynced = true;
      }
    }
    _myEventsLocalService.saveMyEvents(jsonEncode(state.events));
  }

  Future<bool> getCategories() async {
    state = state.copyWith(loading: true);

    final events = await _firebaseFirestore.getEvents(
      path: BackendEndpoint.getEvent,
    );
    if (events != null) {
      final uniqueCategories = <String, MyEventCategory>{};
      for (var e in events.data ?? []) {
        if (e.category != null) {
          uniqueCategories[e.category!.id] =
              MyEventCategory.fromJson(e.category!.toJson());
        }
      }

      state = state.copyWith(
        category: MyEventCategory.fromJson({"id": "0", "name": "عام"}),
        categories: uniqueCategories.values.toList(),
        loading: false,
      );
      _myEventsLocalService.saveCategories(jsonEncode(state.categories));

      return true;
    } else {
      state = state.copyWith(loading: false);
      return false;
    }
  }

  Future<bool> saveCategories(MyEventCategory category) async {
    state = state.copyWith(loading: true);
    try {
      _myEventsLocalService.saveCategories(jsonEncode(category.toJson()));
      state = state.copyWith(
          loading: false,
          category: category,
          categories: [...?state.categories, category]);
      return true;
    } catch (e) {
      log("Error saving categories: $e");
      state = state.copyWith(loading: false);
      return false;
    }
  }

  void changeCategory(MyEventCategory category) {
    state = state.copyWith(
        category: category,
        loading: false,
        categories: [...?state.categories, category]);
  }

  void startInternetListener() {
    InternetConnection().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        log("Start sync events $status");
        syncLocalEvents();
      }
    });
  }
}

class MyEventState {
  bool? loading;
  List<MyEvent?>? events;
  MyEvent? currentEvent;
  MyEventCategory? category;
  List<MyEventCategory>? categories;
// filter events
  List<MyEvent?>? get filterEvents {
    if (category?.id == '0' || category == null) return events ?? [];

    return events
            ?.where((element) => element?.category?.id == category?.id)
            .toList() ??
        [];
  }

  MyEventState({
    this.loading,
    this.events,
    this.currentEvent,
    this.category,
    this.categories,
  });

  MyEventState copyWith({
    bool? loading,
    List<MyEvent?>? events,
    MyEvent? currentEvent,
    MyEventCategory? category,
    List<MyEventCategory>? categories,
  }) {
    return MyEventState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
      currentEvent: currentEvent ?? this.currentEvent,
      category: category ?? this.category,
      categories: categories ?? this.categories,
    );
  }
}
