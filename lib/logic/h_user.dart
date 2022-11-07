import 'package:einstein/data/modules/account.dart';
import 'package:einstein/data/repos/i_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/repos/i_account.dart';
import '../data/repos/i_picture.dart';

class HUser implements IUser{
  final IAccount _db;
  final IPicture _picDB;
  @override
  FirebaseAuth get auth => _db.auth;
  @override
  Future<Account> get cUser => _fetchCurrentUser();
  @override
  String get userID => _db.user.uid;

  HUser(
    this._db,
    this._picDB,
  );

  Future<Account> _fetchCurrentUser() async {
    final user = await getUserByID(userID);
    return user;
  }

  @override
  void signOut() => _db.signOut();

  @override
  void setDarkMode(bool isDark) async {
    final user = await cUser;
    _db.updateAccount(auth.currentUser!.uid, user.copyWith(isDarkMode: isDark));
  }

  @override
  Future<Account> getUserByID(String userID) async {
    return _db.fetchAccountData(userID);
  }

  @override
  Future<String> getCurrentAvatarUrl() async {
    final user = await cUser;
    return getAvatarUrl(user.accPicId);
  }

  @override
  Future<String> getAvatarUrl(String? pictureID) async {
    if (pictureID == null) return _picDB.getAvatarURL(_picDB.baseAvatarID);
    return _picDB.getAvatarURL(pictureID);
  }
}
