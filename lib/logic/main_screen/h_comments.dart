import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/main_screen/modules/comments.dart';
import 'package:einstein/data/main_screen/repos/comments_database.dart';
import 'package:einstein/logic/authentication/h_user.dart';
import 'package:flutter/material.dart';

class HComments extends ChangeNotifier {
  final _db = CommentData();
  final _userHandler = HUser();
  final String postID;
  List<Comments> _comments = [];
  Future<List<Map<String, String>>> get commentsList => _commentsToMap();

  HComments({
    required this.postID,
  }) {
    _fetchCommentsFromPost();
    _db.addListener(() {
      _fetchCommentsFromPost();
    });
  }

  Future<List<Map<String, String>>> _commentsToMap() async {
    final ret = <Map<String, String>>[];
    for (final comment in _comments) {
      final Account user = await _userHandler.getUserByID(comment.author);
      ret.add({
        'name': user.userName,
        'pic': await _userHandler.getAvatarUrl(user.accPicId),
        'message': comment.text
      });
    }
    return ret;
  }

  void _fetchCommentsFromPost() async {
    _comments = [];
    final coms = await _db.fethcComments(postID);
    coms?.forEach((_, value) {
      _comments.add(value);
    });
    notifyListeners();
  }

  void addComment(String msg) {
    final date = DateTime.now();
    final comment = Comments(
      author: _userHandler.userID,
      text: msg,
      replyTo: postID,
      date: date.millisecondsSinceEpoch,
    );
    _db.addComment(postID, comment);
  }
}
