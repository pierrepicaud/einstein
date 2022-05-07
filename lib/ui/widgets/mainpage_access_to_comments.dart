import 'package:flutter/material.dart';

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
  bool updateShouldNotify(CommentListInheritedWidget oldWidget) =>
      comments != oldWidget.comments;
}
