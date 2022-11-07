import 'dart:io';
import 'package:einstein/data/repos/d_account.dart';
import 'package:einstein/data/repos/db_routs.dart';
import 'package:einstein/data/repos/d_post.dart';
import 'package:einstein/data/repos/i_picture.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DPicture extends IPicture{
  final _userDB = DAccount();
  final _postDB = DPosts();
  final _db = FirebaseStorage.instance.ref();

  @override
  String get baseAvatarID => 'noPicture';

  @override
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

  @override
  Future<String> getAvatarURL(String picID) async {
    final url =
        await _db.child(DbRoutes.userAvatarPicture(picID)).getDownloadURL();
    return url;
  }

  @override
  void uploadPostPicture(String postID, String filePath) {
    final file = File(filePath);
    _db.child(DbRoutes.postPicture(postID)).putFile(file).then((p0) async {
      final post = await _postDB.getPost(postID);
      _postDB.updatePost(postID, post.copyWith(picId: postID));
    });
  }

  @override
  Future<String> getPostPictureURL(String picID) async {
    final url = await _db.child(DbRoutes.postPicture(picID)).getDownloadURL();
    return url;
  }
}
