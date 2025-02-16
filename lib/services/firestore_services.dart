import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/constants/backend_endpoint.dart';
import 'package:saudi_calender_task/models/my_event.dart';
import 'package:saudi_calender_task/services/data_services.dart';

part 'generated/firestore_services.g.dart';

class FireStoreService implements DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<bool> addData({
    required String path,
    String? documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
      return true;
    } catch (e) {
      log("Error adding data: $e");
      return false;
    }
  }

  @override
  Future<dynamic> getData({required String path, String? documentId}) async {
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data();
    } catch (e) {
      log("Error getting data: $e");
      return null;
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    try {
      var doc = await firestore.collection(path).doc(documentId).get();
      return doc.exists;
    } catch (e) {
      log("Error checking data existence: $e");
      return false;
    }
  }

  @override
  Future<MyEvent?> addEvent({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log("No user signed in");
      return null;
    }
    try {
      await firestore
          .collection(BackendEndpoint.getUserData)
          .doc(user.uid)
          .collection(path)
          .doc(documentId)
          .set(data);
      return MyEvent.fromJson(data);
    } catch (e) {
      log("Error adding event: $e");
      return null;
    }
  }

  @override
  Future<MyEvents?> getEvent({
    required String path,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      var data = await firestore
          .collection(BackendEndpoint.getUserData)
          .doc(user!.uid)
          .collection(path)
          .get();
      final events = data.docs.map((e) => MyEvent.fromJson(e.data())).toList();
      return MyEvents.fromJson({
        "data": events.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      log("Error getting event: $e");
      return null;
    }
  }

  @override
  Future<MyEvent?> editEvent({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log("No user signed in");
      return null;
    }
    try {
      await firestore
          .collection(BackendEndpoint.getUserData)
          .doc(user.uid)
          .collection(path)
          .doc(documentId)
          .update(data);
      return MyEvent.fromJson(data);
    } catch (e) {
      log("Error adding event: $e");
      return null;
    }
  }

  @override
  Future<bool> deleteEvent({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      log("No user signed in");
      return false;
    }
    try {
      await firestore
          .collection(BackendEndpoint.getUserData)
          .doc(user.uid)
          .collection(path)
          .doc(documentId)
          .delete();
      return true;
    } catch (e) {
      log("Error adding event: $e");
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
FireStoreService fireStoreService(Ref ref) {
  return FireStoreService();
}
