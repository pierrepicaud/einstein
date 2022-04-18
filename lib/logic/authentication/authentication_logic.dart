import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  final AccountData db = AccountData();

  void _setListener() {
    db.auth.authStateChanges().listen((User? user) {
      // ignore: todo
      //TODO: change app state on this callback
      if (user == null) {
        debugPrint("there is no user");
      } else {
        debugPrint("there is a user");
      }
    });
  }

  Future<String?> signIn(String login, String password) async {
    _setListener();
    final userCred = await db.signInWithPassword(login, password);
    return userCred != null ? null : "User not found";
  }

  Future<String?> signUp(String login, String password) async {
    _setListener();
    final userCred = await db.signUpWithPassword(login, password);
    return userCred != null ? null : "Cannot create such user";
  }
}
