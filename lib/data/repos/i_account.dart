import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modules/account.dart';

abstract class IAccount extends ChangeNotifier {
  void addAccount(String accountID, Account account);

  FirebaseAuth get auth;

  void deleteAccount(String accountID);

  Future<Account> fetchAccountData(String? accountID);

  Future<UserCredential?> signInWithPassword(String email, String password);

  void signOut();
  Future<UserCredential?> signUpWithPassword(String email, String password);

  void updateAccount(String accountID, Account account);

  User get user;

  String get userID;
}
