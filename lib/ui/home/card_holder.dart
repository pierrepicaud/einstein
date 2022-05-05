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
    final snapshot =
        context.dependOnInheritedWidgetOfExactType<CardHolderInherit>()!;
    final post = snapshot.currentPost;
    final npost = snapshot.nextPost;
    return Scaffold(
      body: Center(
        //Container with widget
        child: SizedBox(
          height: 450,
          width: 350,
          child: Stack(
            children: <Widget>[
              TinderCard(color: Colors.orange, post: post),
              TinderCard(color: Colors.orange, post: npost),
            ],
          ),
        ),
      ),
    );
  }
}
