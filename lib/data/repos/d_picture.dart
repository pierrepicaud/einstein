import 'dart:io';
import 'package:einstein/data/repos/d_account.dart';
import 'package:einstein/data/repos/db_routs.dart';
import 'package:einstein/data/repos/d_post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DPicture {
  final _userDB = DAccount();
  final _postDB = DPosts();
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
