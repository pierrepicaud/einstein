import 'package:einstein/logic/main_screen/post_hendler.dart';
import 'package:einstein/logic/transitions/custom_route.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/home/homepage.dart';
import 'package:flutter/material.dart';

import 'package:einstein/data/constants.dart';
import 'package:comment_box/comment/comment.dart';
// ignore: todo
//TODO: seporate logic from UI

class MainPage extends StatefulWidget {
  static const routeName = "/home";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final postHandler = PostHandler();

  void listener() => setState(() {});

  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    postHandler.addListener(listener);
  }

  @override
  void dispose() {
    postHandler.removeListener(listener);
    super.dispose();
  }

  List filedata = [
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

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  void __openComments() async {
    await Navigator.of(context).push(MaterialPageRoute<String>(
      builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Comments"),
              backgroundColor: Colors.blue,
            ),
            body: CommentBox(
              userImage:
                  "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
              child: commentChild(filedata),
              labelText: 'Write a comment...',
              withBorder: false,
              errorText: 'Comment cannot be blank',
              sendButtonMethod: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    var value = {
                      'name': 'New User',
                      'pic':
                          'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                      'message': commentController.text
                    };
                    filedata.insert(0, value);
                  });
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                } else {
                  print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
            ));
      },
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final post = postHandler.post;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => postHandler.addPost(),
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
          //const CustTextField(title: '# search', isPass: false), -- textField
          const SizedBox(height: 500, width: 500, child: HomePage()),
          Text(post?.text ?? ''),
          Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: <Widget>[
                  TextButton(
                    child: const Icon(Icons.favorite_outline_sharp),
                    onPressed: () {
                      postHandler.likePressed();
                    },
                  ),
                  Text("${post?.likeCount}"),
                  TextButton(
                    child: const Icon(Icons.share_sharp),
                    onPressed: () {
                      postHandler.sharePressed();
                    },
                  ),
                  Text("${post?.sharedCount}"),
                  TextButton(
                    child: const Icon(Icons.mode_comment_outlined),
                    onPressed: () {
                      print('object');
                      __openComments();
                      //postHandler.nextPost();
                    },
                  ),
                  Text("${post?.commentCount}"),
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

/*class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SingleComment extends StatelessWidget {
  static const _testIconLink =
      'https://previews.123rf.com/images/vgstudio/vgstudio1308/vgstudio130800053/21269255-portrait-der-sch%C3%B6nen-jungen-gl%C3%BCcklich-l%C3%A4chelnde-frau-im-freien.jpg';
  const SingleComment({Key? key, user_photo = _testIconLink}) : super(key: key);
  user_photo

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 38,
        top: 75,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 2.0, color: Colors.grey.shade400),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Image.network(_testIconLink),
                iconSize: Constants.profilePictureSize,
                onPressed: () {},
              ),
              Spacer(flex: 10),
              Text("Name"),
              Spacer(flex: 10),
              Text("Date")
            ],
          ),
          const Text("Here is first coment example")
        ],
      ),
    );
  }
}*/

class SingleComment extends StatelessWidget {
  const SingleComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
