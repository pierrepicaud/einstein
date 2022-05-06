import 'package:einstein/logic/main_screen/h_comments.dart';
import 'package:flutter/material.dart';

//Replace with backend
class CommentProvider {
  static List comments = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];
  static void addNewComment(element) {
    comments.insert(0, element);
  }

  static List get() {
    return comments;
  }
}

class CommentListInheritedWidget extends InheritedWidget {
  

  final String postid;
  final List comments;
  final void listener;


  const CommentListInheritedWidget({
    Key? key,
    required this.postid,
    required this.listener,
    required Widget child,
    required this.comments,
  }) : super(key: key, child: child);

  static CommentListInheritedWidget of(BuildContext context) {
    final CommentListInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<CommentListInheritedWidget>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CommentListInheritedWidget old) =>
      comments != old.comments;
}
