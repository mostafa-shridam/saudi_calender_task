import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/err/exception.dart';
part 'generated/firebase_auth_service.g.dart';
class FirebaseAuthService {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException : ${e.toString()} , e.code : ${e.code}");
      if (e.code == 'weak-password') {
        throw CustomException(message: "كلمة المرور ضعيفة");
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: "البريد الإلكتروني مستخدم بالفعل");
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "تحقق من اتصالك بالانترنت");
      } else {
        throw CustomException(message: "حدث خطأ ما الرجاء المحاولة لاحقا");
      }
    } catch (e) {
      log("CustomExceptionInFirebaseAuthException : ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما الرجاء المحاولة لاحقا");
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException SignIn: ${e.toString()} , e.code : ${e.code}");
      if (e.code == 'invalid-credential') {
        throw CustomException(
          message: "البريد الإلكتروني أو كلمة المرور غير صحيحة",
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          message: "البريد الإلكتروني أو كلمة المرور غير صحيحة",
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "تحقق من اتصالك بالانترنت");
      } else {
        throw CustomException(message: "حدث خطأ ما الرجاء المحاولة لاحقا");
      }
    } catch (e) {
      log("CustomExceptionInFirebaseAuthException SignIn: ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما الرجاء المحاولة لاحقا");
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return (await FirebaseAuth.instance.signInWithCredential(credential))
          .user!;
    } on FirebaseAuthException catch (e) {
      log("CustomExceptionInFirebaseAuthException SignInWithFacebook: ${e.toString()}");

      if (e.code == 'network-request-failed') {
        throw CustomException(message: "تحقق من اتصالك بالانترنت");
      } else {
        throw CustomException(message: "حدث خطأ ما الرجاء المحاولة لاحقا");
      }
    } catch (e) {
      log("CustomExceptionInFirebaseAuthException SignInWithGoogle: ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما الرجاء المحاولة لاحقا");
    }
  }

  bool isSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}

@Riverpod(keepAlive: true)
FirebaseAuthService firebaseAuthService(Ref ref){
  return FirebaseAuthService();
}