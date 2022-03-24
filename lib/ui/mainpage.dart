import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/logic/main_screen/post_hendler.dart';
import 'package:einstein/logic/transitions/custom_route.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/home/homepage.dart';
import 'package:flutter/material.dart';

//TODO: seporate logic from UI

class MainPage extends StatefulWidget {
  static const routeName = "/home";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final postHandler = PostHandler();
  
  Post post = Post("Welcome");
  int i = 0;

  @override
  void initState() {
    super.initState();
    
    postHandler.addListener(() => setState(() {}));
  }

  void setNextPost() {
    post = postHandler.posts[i % 3];
    i += 1;
  }

  @override
  Widget build(BuildContext context) {
    post = postHandler.getCurrentPost();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add)),
      body: SafeArea(
        child: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(FadePageRoute(
                      builder: (context) => const Account(),
                    ));
                  },
                  icon: const Icon(
                    Icons.account_circle,
                    size: 40,
                  ))),
          //const CustTextField(title: '# search', isPass: false),
          const SizedBox(height: 500, width: 500, child: HomePage()),
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
        ]),
      ),
    );
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
