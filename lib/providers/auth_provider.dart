import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saudi_calender_task/core/repos/auth_repo_impl.dart';
part 'generated/auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  late AuthRepoIml authRepoIml;
  @override
  AuthServiceState build() {
    authRepoIml = ref.watch(authRepoProvider);
    return AuthServiceState(
      isSignedIn: false,
      isLoading: false,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await authRepoIml.createUserWithEmailAndPassword(
        email,
        password,
        name,
      );
      if (result.isLeft()) {
        state = state.copyWith(isLoading: false, isSignedIn: false);
        log("Failed to sign up: ${result.isLeft()}");
        return;
      } else {
        state = state.copyWith(isLoading: false, isSignedIn: true);
        log('Signed up successfully.');
      }
    } catch (e) {
      log('Error signing up: $e');
      state = state.copyWith(isLoading: false, isSignedIn: false);
    }
  }

  Future<void> signInWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final result =
          await authRepoIml.signInWithEmailAndPassword(email, password);

      if (result.isLeft()) {
        state = state.copyWith(isLoading: false, isSignedIn: false);
        log("Failed to sign in: ${result.isLeft()}");
        return;
      }
      state = state.copyWith(isLoading: false, isSignedIn: true);
      log('Signed in successfully.');
    } catch (e) {
      log('Error signing in: $e');
      state = state.copyWith(isLoading: false, isSignedIn: false);
    }
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await authRepoIml.signInWithGoogle();
      if (result.isLeft()) {
        state = state.copyWith(isLoading: false, isSignedIn: false);
        log("Failed to sign in: ${result.isLeft()}");
        return false;
      } else {
        state = state.copyWith(isLoading: false, isSignedIn: true);
        log('Signed in successfully.');
        return true;
      }
    } catch (e) {
      log('Error signing in: $e');
      state = state.copyWith(isLoading: false, isSignedIn: false);
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await authRepoIml.signOut();
      state = state.copyWith(isLoading: false, isSignedIn: false);
    } catch (e) {
      log('Error signing out: $e');
      state = state.copyWith(isLoading: false, isSignedIn: false);
    }
  }

  Future<void> deleteUser() async {
    state = state.copyWith(isLoading: true);
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await authRepoIml.deleteUser(user);
      state = state.copyWith(isLoading: false, isSignedIn: false);
    } catch (e) {
      log('Error deleting user: $e');
      state = state.copyWith(isLoading: false, isSignedIn: false);
    }
  }
}

class AuthServiceState {
  bool? isSignedIn;
  bool? isLoading;
  AuthServiceState({this.isSignedIn, this.isLoading});

  copyWith({bool? isSignedIn, bool? isLoading}) {
    return AuthServiceState(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

AuthService authService(Ref ref) {
  return AuthService();
}
