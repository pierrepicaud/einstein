import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/data/main_screen/repos/post_database.dart';
import 'package:flutter/material.dart';

class PostHandler extends ChangeNotifier {
  final _postDb = PostsData();
  final _accountDb = AccountData();
  Map<String, Post>? _posts;
  List<String>? _postsIDs;
  String? get _currentID => _postsIDs?[_currentPost];
  int _currentPost = 0;

  Post? get post => _posts?[_currentID]!;

  PostHandler() {
    _postDb.addListener(() {
      _posts = _postDb.posts;
      _postsIDs = _posts?.keys.toList().reversed.toList();
      print('got notify');
      notifyListeners();
    });
  }

  void addPost(){
    //TODO: TBI
  }

  void nextPost() {
    _currentPost++;
    if (_currentPost > _postsIDs!.length) _currentPost = 0;
    notifyListeners();
  }

  void previousPost() {
    _currentPost--;
    notifyListeners();
  }

  

  void likePressed() async {
    String uid = _accountDb.user!.uid;

    assert(this.post != null);
    assert(_currentID != null);
    final post = this.post!;
    final currentID = _currentID!;
    if (post.likedBy == null) {
      return _postDb.updatePost(
          currentID,
          post.copyWith(
            likeCount: post.likeCount + 1,
            likedBy: [uid],
          ));
    }
    List<String> newLikedBy = post.likedBy!;
    int newLikesCount = post.likeCount;
    if (!post.likedBy!.contains(uid)) {
      newLikedBy.add(uid);
      newLikesCount++;
    } else {
      newLikedBy.remove(uid);
      newLikesCount--;
    }
    return _postDb.updatePost(
        currentID,
        post.copyWith(
          likeCount: newLikesCount,
          likedBy: newLikedBy,
        ));
  }

  void sharePressed() async {
    //TODO: TBI
  }
}
