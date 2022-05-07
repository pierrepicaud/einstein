import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/main_screen/repos/picture_database.dart';

class HUser {
  final _db = AccountData();
  final _picDB = PictureData();
  Account? _user;
  Future<Account> get cUser =>
      _user == null ? _fetchCurrentUser() : Future.value(_user);
  String get userID => _db.user.uid;

  Future<Account> _fetchCurrentUser() async {
    _user = await getUserByID(userID);
    return _user!;
  }

  Future<Account> getUserByID(String userID) async {
    print('getting user');
    return _db.fetchAccountData(userID);
  }

  Future<String> getAvatarUrl(String? pictureID) async {
    if (pictureID == null) return _picDB.getAvatarURL(_picDB.baseAvatarID);

    return _picDB.getAvatarURL(pictureID);
    ;
  }
}
