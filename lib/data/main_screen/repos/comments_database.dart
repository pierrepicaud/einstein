import 'package:einstein/data/db_routs.dart';
import 'package:einstein/data/main_screen/modules/comments.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostsData extends ChangeNotifier {
  final _db = FirebaseDatabase.instance.ref();

  void _updateData(Map<String, Map?> updates) async =>
      _db.update(updates).then((_) => notifyListeners());

  Future<List<String>?> _getCommentsIDsList(String postID) async {
    final snapshot = await _db.child(DbRoutes.postComments(postID)).get();
    return snapshot.value == null
        ? null
        : List<String>.from(snapshot.value as List<dynamic>);
  }

  List<Future<DataSnapshot>> _getListOfComments(List<String> commentsIDs){
    final snapshots = <Future<DataSnapshot>>[];
    for(final commentID in commentsIDs){
       snapshots.add(_db.child(DbRoutes.comments).equalTo(commentID).get());
    }
    return snapshots;
  }

  Future<Map<String, Comments>?> fethcComments(String postID) async {
    List<String>? commentsIDs = await _getCommentsIDsList(postID);
    if(commentsIDs == null) return null;
    final Map<String, Comments> comments = {};
    final commentsList = _getListOfComments(commentsIDs);
    for(final com in commentsList){
      final snapshot = await com;
      final entry = snapshot.value as MapEntry<dynamic, dynamic>;
      comments[entry.key as String] = Comments.fromMap(Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>));
    }
    return comments;
  }

  void updatecomment(String commentID, Comments comment) async {
    Map<String, Map> updates = {};
    updates[DbRoutes.commentData(commentID)] = comment.toMap();
    return _updateData(updates);
  }

  void addComment(String postID, Comments comment) async {
    // Map<String, Map> updates = {};
    // final newPostKey = db.child(DbRoutes.comments).push().key;
    // updates[DbRoutes.commentData(newPostKey!)] = comment.toMap();
    // return _updateData(updates);
  }

  void deleteComment(String commentID) async {
    // Map<String, Map?> updates = {};
    // updates[DbRoutes.commentData(commentID)] = null;
    // return _updateData(updates);
  }
}
