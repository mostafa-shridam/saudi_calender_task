import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/enums/constants_enums.dart';
import 'package:saudi_calender_task/core/local_service/local_storage.dart';
import 'package:saudi_calender_task/models/user_model.dart';

import '../../services/data_services.dart';
import '../../services/firebase_auth_service.dart';
import '../constants/backend_endpoint.dart';
import '../err/exception.dart';
import '../err/failures.dart';
import 'auth_repo.dart';
part 'generated/auth_repo_impl.g.dart';

class AuthRepoIml implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  final LocalStorage localStorage;

  AuthRepoIml({
    required this.databaseService,
    required this.firebaseAuthService,
    required this.localStorage,
  });

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userModel = UserModel(
        name: name,
        email: email,
        uId: user.uid,
        image: user.photoURL ?? '',
      );
      await addUserData(user: userModel);
      await saveUserData(user: userModel);
      return right(userModel);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}');
      return left(ServerFailure(message: "حدث خطأ ما الرجاء المحاولة لاحقا"));
    }
  }

  @override
  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await user.delete();
      await FirebaseAuth.instance.currentUser!.delete();
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userEntity = await getUserData(uid: user.uid);
      await addUserData(user: userEntity);
      await saveUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return left(ServerFailure(message: "حدث خطأ ما الرجاء المحاولة لاحقا"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);

      var isUserExist = await databaseService.checkIfDataExists(
          path: BackendEndpoint.users, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid);
        await saveUserData(user: userEntity);
      } else {
        await addUserData(user: userEntity);
        await saveUserData(user: userEntity);
      }

      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(ServerFailure(message: "حدث خطأ ما الرجاء المحاولة لاحقا"));
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthService.signOut();
  }

  @override
  Future<void> addUserData({required UserModel? user}) async {
    await databaseService.addData(
      documentId: user?.uId,
      path: BackendEndpoint.users,
      data: user?.toMap(),
    );
  }

  @override
  Future<UserModel> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
      path: BackendEndpoint.users,
      documentId: uid,
    );
    return UserModel.fromJson(userData);
  }

  @override
  Future<void> saveUserData({required UserModel? user}) async {
    await localStorage.put(
        ConstantsEnums.saveUserData.name, jsonEncode(user?.toMap()));
  }

  @override
  UserModel? getUserDataLocal() {
    final data = localStorage.get(ConstantsEnums.saveUserData.name);
    if (data == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(data));
  }
}

@Riverpod(keepAlive: true)
AuthRepoIml authRepo(Ref ref) {
  return AuthRepoIml(
    firebaseAuthService: ref.watch(firebaseAuthServiceProvider),
    databaseService: ref.watch(databaseServiceProvider),
    localStorage: ref.watch(localStorageProvider),
  );
}
