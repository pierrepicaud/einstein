import 'dart:io';

import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/db_routs.dart';
import 'package:einstein/data/main_screen/repos/post_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PictureData {
  final _userDB = AccountData();
  final _postDB = PostsData();
  final _db = FirebaseStorage.instance.ref();

  String get baseAvatarID => 'noPicture';

  void uploadAvatar(String filePath) async {
    final file = File(filePath);

    _db
        .child(DbRoutes.userAvatarPicture(_userDB.userID))
        .putFile(file)
        .then((p0) async {
      final acc = await _userDB.fetchAccountData(null);
      _userDB.updateAccount(
          _userDB.userID, acc.copyWith(accPicId: _userDB.userID));
    });
  }

  Future<String> getAvatarURL(String picID) async {
    final url =
        await _db.child(DbRoutes.userAvatarPicture(picID)).getDownloadURL();
    return url;
  }

  void uploadPostPicture(String postID, String filePath) {
    final file = File(filePath);
    _db.child(DbRoutes.postPicture(postID)).putFile(file).then((p0) async {
      final post = await _postDB.getPost(postID);
      _postDB.updatePost(postID, post.copyWith(picId: postID));
    });
  }

  Future<String> getPostPictureURL(String picID) async {
    final url = await _db.child(DbRoutes.postPicture(picID)).getDownloadURL();
    return url;
  }
}
