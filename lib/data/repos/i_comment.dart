import 'package:flutter/cupertino.dart';

import '../modules/comments.dart';

abstract class IComment extends ChangeNotifier{
  void addComment(String postID, Comments comment);

  void deleteComment(String commentID);

  Future<Map<String, Comments>?> fethcComments(String postID);

  void updatecomment(String commentID, Comments comment);
}
