import 'dart:html';

import 'package:flutter/material.dart';
import 'homepage.dart';
import 'widgets/tinder_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class Post {
  String text = "Example text";
  int likes = 0;
  int share = 0;
  int coments = 0;
  Post(this.text);
}

class _MainPageState extends State<MainPage> {
  final List list = <Post>[
    Post("Example text 1"),
    Post("Example text 2"),
    Post("Example text 3")
  ];
  Post post = Post("Welcome");
  int i = 0;

  void setNextPost() {
    post = list[i % 3];
    i += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment Counter',
            child: const Icon(Icons.add)),
        body: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle,
                    size: 40,
                  ))),
          const CustTextField(title: '# search', isPass: false),
          SizedBox(height: 500, width: 500, child: HomePage()),
          Text(post.text),
          Container(
              alignment: Alignment.topCenter,
              //padding: const EdgeInsets.only(left: 100),
              child: Row(
                children: <Widget>[
                  //Spacer(flex: 1),
                  TextButton(
                    child: const Icon(Icons.favorite_outline_sharp),
                    onPressed: () {
                      setState(() {
                        post.likes += 1;
                      });
                    },
                  ),
                  Text("${post.likes}"),
                  TextButton(
                    child: const Icon(Icons.share_sharp),
                    onPressed: () {
                      setState(() {
                        post.share += 1;
                      });
                    },
                  ),
                  Text("${post.share}"),
                  TextButton(
                    child: const Icon(Icons.mode_comment_outlined),
                    onPressed: () {
                      setState(() {
                        setNextPost();
                      });
                    },
                  ),
                  Text("${post.coments}"),
                ],
              ))
        ]));
  }
}

class CustTextField extends StatelessWidget {
  final String title;
  final bool isPass;
  const CustTextField({Key? key, required this.title, required this.isPass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Color.fromARGB(255, 152, 197, 219),
        margin: const EdgeInsets.symmetric(horizontal: 80),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        //padding: const EdgeInsets.symmetric(),
        //alignment: Alignment.center,
        width: 450,
        height: 40,
        child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: title,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
            obscureText: isPass,
            style: const TextStyle(fontSize: 15)));
  }
}
