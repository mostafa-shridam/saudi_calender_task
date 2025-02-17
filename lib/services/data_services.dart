import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/my_event.dart';
import 'firestore_services.dart';
part 'generated/data_services.g.dart';

abstract class DatabaseService {
  Future<bool> addData({
    required String path,
    required Map<String, dynamic>? data,
    String? documentId,
  });
  Future<dynamic> getData({
    required String path,
    String? documentId,
  });
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
  Future<MyEvent?> addEvents({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });
  Future<MyEvents?> getEvents({
    required String path,
  });
  Future<MyEvent?> editEvent({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });
  Future<bool> deleteEvent({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });
}

@Riverpod(keepAlive: true)
DatabaseService databaseService(Ref ref) {
  return FireStoreService();
}
