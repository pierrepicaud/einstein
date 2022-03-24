import 'package:einstein/ui/widgets/tinder_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: 300,
          width: 200,
          child: Stack(
            children: const [
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
