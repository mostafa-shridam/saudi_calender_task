import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saudi_calender_task/models/user_model.dart';

import '../err/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
      String email, String password, String name);

  Future<Either<Failure, UserModel>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> addUserData({required UserModel user});
  Future<void> getUserData({required String uid});
  Future<void> saveUserData({required UserModel user});

  Future<Either<Failure, UserModel?>?>? signInWithGoogle();
  Future<void> deleteUser(User? user);
  Future<void> signOut();
  UserModel? getUserDataLocal() {
    return null;
  }
}
