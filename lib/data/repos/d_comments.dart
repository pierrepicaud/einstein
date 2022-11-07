import 'package:einstein/data/modules/comments.dart';
import 'package:einstein/data/repos/db_routs.dart';
import 'package:einstein/data/repos/d_post.dart';
import 'package:einstein/data/repos/i_comment.dart';
import 'package:firebase_database/firebase_database.dart';
class DComment extends IComment{
  final _db = FirebaseDatabase.instance.ref();
  final _postDB = DPosts();

  void _updateData(Map<String, Map?> updates) async =>
      _db.update(updates).then((_) => notifyListeners());

  Future<List<String>?> _getCommentsIDsList(String postID) async {
    final snapshot = await _db.child(DbRoutes.postComments(postID)).get();
    return snapshot.value == null
        ? null
        : List<String>.from(snapshot.value as List<dynamic>);
  }

  List<Future<DataSnapshot>> _getListOfComments(List<String> commentsIDs) {
    final snapshots = <Future<DataSnapshot>>[];
    for (final commentID in commentsIDs) {
      snapshots.add(_db.child(DbRoutes.commentData(commentID)).get());
    }
    return snapshots;
  }

  @override
  Future<Map<String, Comments>?> fethcComments(String postID) async {
    List<String>? commentsIDs = await _getCommentsIDsList(postID);
    if (commentsIDs == null) return null;
    final Map<String, Comments> comments = {};
    final commentsList = _getListOfComments(commentsIDs);
    for (final key in commentsList.asMap().keys) {
      final snapshot = await commentsList[key];
      final map =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      comments[commentsIDs[key]] = Comments.fromMap(map);
    }
    return comments;
  }

  @override
  void updatecomment(String commentID, Comments comment) async {
    Map<String, Map> updates = {};
    updates[DbRoutes.commentData(commentID)] = comment.toMap();
    return _updateData(updates);
  }

  @override
  void addComment(String postID, Comments comment) async {
    Map<String, Map> updates = {};
    final post = await _postDB.getPost(postID);
    final commetList = post.comments ?? [];
    final newCommentKey = _db.child(DbRoutes.comments).push().key;
    updates[DbRoutes.commentData(newCommentKey!)] = comment.toMap();
    commetList.add(newCommentKey);
    updates[DbRoutes.postData(postID)] = post
        .copyWith(comments: commetList, commentCount: post.commentCount + 1)
        .toMap();
    return _updateData(updates);
  }

  @override
  void deleteComment(String commentID) async {
    Map<String, Map?> updates = {};
    updates[DbRoutes.commentData(commentID)] = null;
    return _updateData(updates);
  }
}
