import 'package:einstein/ui/widgets/tinder_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 200,
          child: Stack(
            children: [
              // tinder card stack
              TinderCard(color: Colors.deepOrange),
              TinderCard(color: Colors.deepPurple),
              TinderCard(color: Colors.deepOrangeAccent),
              TinderCard(color: Colors.deepPurpleAccent),
            ],
          ),
        ),
      ),
    );
  }
}
