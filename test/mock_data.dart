import 'package:einstein/data/modules/account.dart';
import 'package:einstein/data/modules/comments.dart';
import 'package:einstein/data/modules/post.dart';

import 'package:einstein/data/repos/d_account.dart';
import 'package:einstein/data/repos/d_comments.dart';
import 'package:einstein/data/repos/d_picture.dart';
import 'package:einstein/data/repos/d_post.dart';
import 'package:einstein/data/repos/i_account.dart';
import 'package:einstein/data/repos/i_comment.dart';
import 'package:einstein/data/repos/i_picture.dart';
import 'package:einstein/data/repos/i_post.dart';
import 'package:einstein/data/repos/i_user.dart';
import 'package:einstein/logic/h_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockAccount extends IAccount {
  @override
  Future<Account> fetchAccountData(String? accountID) {
    return Future.value(
      Account.fromMap({
        'userName': 'bebra',
        'followersCount': 50,
      }),
    );
  }

  @override
  String get userID => 'asdffgsfgsfgjhjhgashdg';

  @override
  void addAccount(String accountID, Account account) {
    // TODO: implement addAccount
  }

  @override
  // TODO: implement auth
  FirebaseAuth get auth => throw UnimplementedError();

  @override
  void deleteAccount(String accountID) {
    // TODO: implement deleteAccount
  }

  @override
  Future<UserCredential?> signInWithPassword(String email, String password) {
    // TODO: implement signInWithPassword
    throw UnimplementedError();
  }

  @override
  void signOut() {
    // TODO: implement signOut
  }

  @override
  Future<UserCredential?> signUpWithPassword(String email, String password) {
    // TODO: implement signUpWithPassword
    throw UnimplementedError();
  }

  @override
  void updateAccount(String accountID, Account account) {
    // TODO: implement updateAccount
  }

  @override
  // TODO: implement user
  User get user => throw UnimplementedError();
}

class MockComment extends IComment {
  @override
  Future<Map<String, Comments>?> fethcComments(String postID) {
    return Future.value({
      "asdfasdf": Comments(
        author: 'asdffgsfgsfgjhjhgashdg',
        text: 'text',
        replyTo: '',
        date: 123125125623,
      )
    });
  }

  @override
  void addComment(String postID, Comments comment) {
    // TODO: implement addComment
  }

  @override
  void deleteComment(String commentID) {
    // TODO: implement deleteComment
  }

  @override
  void updatecomment(String commentID, Comments comment) {
    // TODO: implement updatecomment
  }
}

class MockUser extends IUser {
  final IAccount _db;

  MockUser(this._db);

  Future<Account> _fetchCurrentUser() async {
    final user = await getUserByID(userID);
    return user;
  }

  @override
  Future<Account> get cUser => _fetchCurrentUser();

  @override
  Future<String> getAvatarUrl(String? pictureID) {
    return Future.value(
        'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg');
  }

  @override
  Future<String> getCurrentAvatarUrl() {
    return Future.value(
        'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg');
  }

  @override
  Future<Account> getUserByID(String userID) {
    return Future.value(
      Account.fromMap({
        'userName': 'bebra',
        'followersCount': 50,
      }),
    );
  }

  @override
  String get userID => _db.userID;

  @override
  // TODO: implement auth
  FirebaseAuth get auth => throw UnimplementedError();

  @override
  void setDarkMode(bool isDark) {
    // TODO: implement setDarkMode
  }

  @override
  void signOut() {
    // TODO: implement signOut
  }
}

class MockPosts extends IPosts {
  @override
  Future<Post> getPost(postID) {
    return Future.value(posts![postID]);
  }

  @override
  Map<String, Post>? get posts => {
        'asdf': const Post(
          author: 'asdffgsfgsfgjhjhgashdg',
          date: 123413,
        )
      };

  @override
  void addPost(Post post) {
    // TODO: implement addPost
  }

  @override
  void deletePost(String postID) {
    // TODO: implement deletePost
  }

  @override
  void updatePost(String postID, Post post) {
    // TODO: implement updatePost
  }
}

class MockPicture extends IPicture {
  @override
  Future<String> getAvatarURL(String picID) {
    return Future.value(
        'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg');
  }

  @override
  Future<String> getPostPictureURL(String picID) {
    return Future.value(
        'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg');
  }

  @override
  // TODO: implement baseAvatarID
  String get baseAvatarID => 'asdf';

  @override
  void uploadAvatar(String filePath) {
    // TODO: implement uploadAvatar
  }

  @override
  void uploadPostPicture(String postID, String filePath) {
    // TODO: implement uploadPostPicture
  }
}
