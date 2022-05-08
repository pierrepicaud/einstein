import 'package:einstein/data/modules/card_events.dart';
import 'package:einstein/data/modules/post.dart';
import 'package:flutter/material.dart';

class CardHolderInherit extends InheritedWidget {
  final Post currentPost;
  final void Function(CardEvent)? callback;

  const CardHolderInherit({
    Key? key,
    required Widget child,
    required this.currentPost,
    this.callback,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(CardHolderInherit oldWidget) {
    return true; //currentPost != oldWidget.currentPost;
  }
}