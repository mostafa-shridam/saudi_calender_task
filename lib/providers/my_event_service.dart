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

  Future<void> getLocalMyEvents() async {
    state = state.copyWith(loading: true);
    final events = _myEventsLocalService.getMyEvents();
    if (events != null) {
      state = state.copyWith(
        events: events.data?..map((e) => MyEvent.fromJson(e.toJson())).toList(),
        loading: false,
      );
    } else {
      state = state.copyWith(loading: false);
    }
  }

  Future<bool> addEvent(MyEvent event) async {
    state = state.copyWith(loading: true);
    try {
      event.id = _uuid.v4();
      final internetAvailable = await InternetConnection().hasInternetAccess;
      MyEvent? result = await (internetAvailable
          ? _firebaseFirestore.addEvent(
              path: BackendEndpoint.addEvent,
              data: event.toJson(),
              documentId: event.id!,
            )
          : addLocalEvent(event));

      if (result != null) {
        final updatedEvents = [...?state.events, result];
        state = state.copyWith(
          loading: false,
          currentEvent: result,
          events: updatedEvents,
        );
        _myEventsLocalService.saveMyEvents(jsonEncode(updatedEvents));
      }
      return true;
    } catch (e) {
      log("Error adding event: $e");
      state = state.copyWith(loading: false);
      return false;
    }
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
        documentId: event.id!,
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
    state = state.copyWith(loading: state.events == null);
    final events = await _firebaseFirestore.getEvent(
      path: BackendEndpoint.getEvent,
    );
    if (events != null) {
      state = state.copyWith(
        events: events.data
          ?..sort((a, b) => a.startsAt?.compareTo(b.startsAt ?? '') ?? 0),
        loading: false,
      );
    } else {
      state = state.copyWith(loading: false);
      getLocalMyEvents();
    }
  }

  Future<MyEvent?> addLocalEvent(MyEvent event) async {
    state = state.copyWith(loading: true);
    event.id = _uuid.v4();

    try {
      state.events?.map((e) => e?.id == event.id ? event : e).toList();
      _myEventsLocalService.saveMyEvents(jsonEncode(event));
      return event;
    } catch (e) {
      log("Error adding local event: $e");
      state = state.copyWith(loading: false);
      return null;
    }
  }

  Future<bool> deleteLocalEvent(MyEvent event) async {
    state = state.copyWith(loading: true);
    try {
      state.events?.removeWhere((e) => e?.id == event.id);
      _myEventsLocalService
          .saveMyEvents(jsonEncode(state.events?.map((e) => e?.id).toList()));

      return true;
    } catch (e) {
      log("Error deleting local event: $e");
      state = state.copyWith(loading: false);
      return false;
    }
  }
}

class MyEventState {
  final bool loading;
  final List<MyEvent?>? events;
  final MyEvent? currentEvent;
  final String? hash;

  const MyEventState({
    this.loading = false,
    this.events,
    this.currentEvent,
    this.hash,
  });

  MyEventState copyWith({
    bool? loading,
    List<MyEvent?>? events,
    MyEvent? currentEvent,
    String? hash,
  }) {
    return MyEventState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
      currentEvent: currentEvent ?? this.currentEvent,
      hash: hash ?? this.hash,
    );
  }
}
