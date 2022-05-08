import 'package:flutter/material.dart';

class CommentListInherit extends InheritedWidget {
  final String postid;
  final List comments;

  const CommentListInherit({
    Key? key,
    required this.postid,
    required Widget child,
    required this.comments,
  }) : super(key: key, child: child);

  static CommentListInherit of(BuildContext context) {
    final CommentListInherit? result = context
        .dependOnInheritedWidgetOfExactType<CommentListInherit>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CommentListInherit oldWidget) =>
      comments != oldWidget.comments;
}
