import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/data/main_screen/repos/post_database.dart';
import 'package:flutter/material.dart';

class PostHandler extends ChangeNotifier{

  final _postDb = PostData();
  Post _currentPost = Post("Welcome!");
  var _i = 0;

  List<Post> get posts => _postDb.posts;
  
  Post getCurrentPost() => _currentPost;

  void setNextPost() {
    _currentPost = posts[_i % 3];
    _i += 1;

    notifyListeners();
  }

  void addLike(){
    _currentPost.likes++;

    notifyListeners();
  }

  void addShare(){
    _currentPost.share++;

    notifyListeners();
  }

}