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
  final List comments = CommentProvider.get();
  final void listener;
  void addComment(value) {
    CommentProvider.addNewComment(value);
    listener;
  }

  CommentListInheritedWidget({
    Key? key,
    required this.postid,
    required this.listener,
    required Widget child,
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
