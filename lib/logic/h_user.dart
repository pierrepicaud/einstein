import 'package:einstein/data/modules/account.dart';
import 'package:einstein/data/repos/d_account.dart';
import 'package:einstein/data/repos/d_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HUser {
  final _db = DAccount();
  final _picDB = DPicture();
  FirebaseAuth get auth => _db.auth;
  Future<Account> get cUser => _fetchCurrentUser();
  String get userID => _db.user.uid;
  
  Future<Account> _fetchCurrentUser() async {
    final user = await getUserByID(userID);
    return user;
  }

  void signOut() => _db.signOut();

  void setDarkMode(bool isDark) async {
    final user = await cUser;
    _db.updateAccount(auth.currentUser!.uid, user.copyWith(isDarkMode: isDark));
  }

  Future<Account> getUserByID(String userID) async {
    return _db.fetchAccountData(userID);
  }

  Future<String> getCurrentAvatarUrl() async {
    final user = await cUser;
    return getAvatarUrl(user.accPicId);
  }

  Future<String> getAvatarUrl(String? pictureID) async {
    if (pictureID == null) return _picDB.getAvatarURL(_picDB.baseAvatarID);
    return _picDB.getAvatarURL(pictureID);
    ;
  }
}
