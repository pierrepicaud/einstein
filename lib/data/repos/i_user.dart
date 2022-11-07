import 'package:firebase_auth/firebase_auth.dart';

import '../modules/account.dart';

abstract class IUser {
  FirebaseAuth get auth;

  Future<Account> get cUser;

  Future<String> getAvatarUrl(String? pictureID);

  Future<String> getCurrentAvatarUrl();

  Future<Account> getUserByID(String userID);

  void setDarkMode(bool isDark);

  void signOut();
  String get userID;
}
