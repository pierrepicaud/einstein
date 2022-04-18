import 'package:einstein/data/db_routs.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostsData extends ChangeNotifier {
  DatabaseReference db = FirebaseDatabase.instance.ref();
  Map<String, Post>? _posts;
  Map<String, Post>? get posts => _posts;

  PostsData() {
    db
        .child(DbRoutes.posts)
        .orderByChild('date')
        .limitToLast(10)
        .onValue
        .listen((event) {
      final map = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
      _posts = map.map((key, value) => MapEntry(key, Post.fromMap(Map<String, dynamic>.from(value as Map<dynamic, dynamic>))),);
      print(_posts);
      notifyListeners();
    });
  }

  void _updateData(Map<String, Map?> updates) =>
      db.update(updates).then((_) => notifyListeners());

  void updatePost(String postID, Post post) async {
    Map<String, Map> updates = {};
    updates[DbRoutes.postData(postID)] = post.toMap();
    return _updateData(updates);
  }

  void addPost(Post post) async {
    Map<String, Map> updates = {};
    final newPostKey = db.child(DbRoutes.posts).push().key;
    // can shoot in a leg since I have no idea
    // why new key is "String?"
    updates[DbRoutes.postData(newPostKey!)] = post.toMap();
    return _updateData(updates);
  }

  void deletePost(String postID) async {
    Map<String, Map?> updates = {};
    updates[DbRoutes.postData(postID)] = null;
    return _updateData(updates);
  }
}
