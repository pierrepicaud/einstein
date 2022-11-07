import 'package:einstein/data/modules/post.dart';
import 'package:flutter/material.dart';


abstract class IPosts extends ChangeNotifier{
  void addPost(Post post);

  void deletePost(String postID);

  Future<Post> getPost(postID);

  Map<String, Post>? get posts;

  void updatePost(String postID, Post post);
}
