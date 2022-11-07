import 'package:einstein/data/modules/account.dart';
import 'package:einstein/data/modules/comments.dart';
import 'package:flutter/material.dart';

import '../data/repos/i_comment.dart';
import '../data/repos/i_user.dart';

class HComments extends ChangeNotifier {
  final IComment _db;
  final IUser _userHandler;
  final String postID;
  List<Comments> _comments = [];
  Future<List<Map<String, String>>> get commentsList => _commentsToMap();

  HComments(
    this._db,
    this._userHandler, {
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
