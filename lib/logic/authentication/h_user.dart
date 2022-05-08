import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/main_screen/repos/picture_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HUser {
  final _db = AccountData();
  final _picDB = PictureData();
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
    print('isDark: $isDark');
    _db.updateAccount(auth.currentUser!.uid, user.copyWith(isDarkMode: isDark));
  }

  Future<Account> getUserByID(String userID) async {
    print('getting user');
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
