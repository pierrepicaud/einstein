import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/data/main_screen/repos/post_database.dart';
import 'package:flutter/material.dart';

class PostHandler extends ChangeNotifier{

  final _postDb = PostData();

  List<Post> get posts => _postDb.posts;
  
  Post get currentPost => 

}