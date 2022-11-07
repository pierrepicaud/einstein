import 'package:einstein/data/modules/post.dart';
import 'package:einstein/data/repos/db_routs.dart';
import 'package:einstein/data/repos/i_post.dart';
import 'package:firebase_database/firebase_database.dart';

class DPosts  extends IPosts{
  final _db = FirebaseDatabase.instance.ref();
  Map<String, Post>? _posts;
  @override
  Map<String, Post>? get posts => _posts;

  DPosts() {
    _db
        .child(DbRoutes.posts)
        .limitToLast(200)
        .onValue
        .listen((event) {
      final map = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      _posts = map.map(
        (key, value) => MapEntry(
            key,
            Post.fromMap(
                Map<String, dynamic>.from(value as Map<dynamic, dynamic>))),
      );
      notifyListeners();
    });
  }

  @override
  Future<Post> getPost(postID) async {
    final snapshot = await _db.child(DbRoutes.postData(postID)).get();
    final map =
        Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
    return Post.fromMap(map);
  }

  void _updateData(Map<String, Map?> updates) async =>
      _db.update(updates).then((_) => notifyListeners());

  @override
  void updatePost(String postID, Post post) async {
    Map<String, Map> updates = {};
    updates[DbRoutes.postData(postID)] = post.toMap();
    return _updateData(updates);
  }

  @override
  void addPost(Post post) async {
    Map<String, Map> updates = {};
    final newPostKey = _db.child(DbRoutes.posts).push().key;
    updates[DbRoutes.postData(newPostKey!)] = post.toMap();
    return _updateData(updates);
  }

  @override
  void deletePost(String postID) async {
    Map<String, Map?> updates = {};
    updates[DbRoutes.postData(postID)] = null;
    return _updateData(updates);
  }
}
