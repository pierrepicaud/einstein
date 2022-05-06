import 'dart:io';

import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/db_routs.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PictureData {
  final _userDB = AccountData();
  final _db = FirebaseStorage.instance.ref();

  String get baseAvatarUrl =>
      'gs://einstein-cb7c2.appspot.com/avatar/image_2022-05-06_144921479.png';

  void uploadAvatar(String filePath) async {
    final file = File(filePath);

    _db
        .child(DbRoutes.userAvatarPicture(_userDB.userID))
        .putFile(file)
        .then((p0) async {
      final acc = await _userDB.fetchAccountData(null);
      _userDB.updateAccount(_userDB.userID, acc.copyWith(accPicId: _userDB.userID));
    });
  }

  Future<String> getAvatarURL(String userID) async {
    final url = await _db.child(DbRoutes.userAvatarPicture(userID)).getDownloadURL();
    return url;
  }

  // void uploadPostPicture()
  // String downloadPostPicture()
}
