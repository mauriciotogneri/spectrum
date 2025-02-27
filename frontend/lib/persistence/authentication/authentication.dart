import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:testflow/utils/error_handler.dart';
import 'package:testflow/utils/firebase_config.dart';
import 'package:testflow/utils/log.dart';

class Authentication {
  static User? get currentUser => FirebaseConfig.auth().currentUser;

  static String get userId => currentUser?.uid ?? '';

  static String get userEmail => currentUser?.email ?? '';

  static bool get isAuthenticated => currentUser != null;

  static bool get isEmailVerified => currentUser?.emailVerified ?? false;

  static Future<IdTokenResult>? getIdToken() =>
      currentUser?.getIdTokenResult(true);

  static Future reloadToken() async {
    try {
      Log.trace('Authentication', 'Reloading token');
      return getIdToken();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  static Future? reloadSession() => currentUser?.reload();

  static void checkIfAuthenticated({
    required Function(User) onSuccess,
    required VoidCallback onError,
  }) {
    final Stream<User?> stream = FirebaseConfig.auth().authStateChanges();
    StreamSubscription? subscription;
    subscription = stream.listen((user) async {
      await subscription?.cancel();

      if (user != null) {
        try {
          await user.reload();
          onSuccess(user);
        } catch (e) {
          ErrorHandler.handle(e);

          onError();
        }
      } else {
        onError();
      }
    });
  }

  static Future signUp({required String email, required String password}) =>
      FirebaseConfig.auth().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  static Future signIn({required String email, required String password}) =>
      FirebaseConfig.auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  static Future reauthenticate({required String password}) {
    final AuthCredential credential = EmailAuthProvider.credential(
      email: Authentication.userEmail,
      password: password,
    );

    return currentUser!.reauthenticateWithCredential(credential);
  }

  static Future signOut() => FirebaseConfig.auth().signOut();
}
