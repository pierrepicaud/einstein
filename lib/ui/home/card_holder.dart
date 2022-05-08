import 'package:einstein/ui/mainpage.dart';
import 'package:einstein/ui/widgets/tinder_card.dart';
import 'package:flutter/material.dart';

class CardHolder extends StatefulWidget {
  static const String routeName = "/home";

  const CardHolder({
    Key? key,
  }) : super(key: key);

  @override
  State<CardHolder> createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  @override
  Widget build(BuildContext context) {
    // this keys are a kostil to say flutter that it needs to rebuild widgets in a Stack
    Key k1 = UniqueKey();
    Key k2 = UniqueKey();
    final snapshot =
        context.dependOnInheritedWidgetOfExactType<CardHolderInherit>()!;
    final post = snapshot.currentPost;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          //Container with widget
          child: Stack(
            children: <Widget>[
              TinderCard(key: k2, color: Theme.of(context).colorScheme.secondary),
              TinderCard(key: k1, color: Theme.of(context).colorScheme.secondary, post: post),
            ],
          ),
        ),
      ),
    );
  }
}
