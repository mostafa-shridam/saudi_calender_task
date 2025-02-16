

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
  Future addUserData({required UserModel user});
  Future getUserData({required String uid});
  Future saveUserData({required UserModel user});

  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future deleteUser(User? user);
  Future signOut();
}
