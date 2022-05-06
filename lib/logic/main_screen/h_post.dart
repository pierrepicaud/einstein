import 'package:einstein/data/authentication/repos/account_database.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/data/main_screen/repos/picture_database.dart';
import 'package:einstein/data/main_screen/repos/post_database.dart';
import 'package:flutter/material.dart';

class HPost extends ChangeNotifier {
  final _postDb = PostsData();
  final _accountDb = AccountData();
  final _picDb = PictureData();
  Map<String, Post>? _posts;
  List<String>? _postsIDs;
  String? get _currentID => _postsIDs?[_currentPost];
  int _currentPost = 0;
  
  String? get postID => _currentID;
  Post? get post => _posts?[_currentID]!;
  Post? get npost => _posts?[_postsIDs?[_currentPost + 1 < _postsIDs!.length? _currentPost + 1 : 0]]!;

  HPost() {
    _postDb.addListener(() {
      _posts = _postDb.posts;
      _postsIDs = _posts?.keys.toList().reversed.toList();
      notifyListeners();
    });
  }

  Future<Post?> fetchPostByID(String postID) async => _postDb.getPost(postID);

  void addPost(){
    //TODO: TBI
  }

  void nextPost() {
    _currentPost++;
    if (_currentPost >= _postsIDs!.length) _currentPost = 0;
    notifyListeners();
  }

  void previousPost() {
    if(_currentPost == 0) _currentPost = _postsIDs!.length; 
    _currentPost--;
    notifyListeners();
  }

  
  Future<String> getPictureUrl(String picID) async {
    return _picDb.getPostPictureURL(picID);
  }


  void likePressed() async {
    String uid = _accountDb.user.uid;

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
