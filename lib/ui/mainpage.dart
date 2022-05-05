import 'package:einstein/data/main_screen/modules/card_events.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/logic/main_screen/post_hendler.dart';
import 'package:einstein/logic/transitions/custom_route.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/home/card_holder.dart';
import 'package:flutter/material.dart';
import 'package:einstein/ui/widgets/mainpage_comments_page.dart';
import 'package:einstein/ui/widgets/mainpage_access_to_comments.dart';

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
  int currentIndex = 0;

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

  /*Widget commentChild(data) {
    return 
  }*/

  void addcomment() {}
  void __openComments() async {
    String postid = "1";
    await Navigator.of(context).push(MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return CommentListInheritedWidget(
              postid: postid,
              listener: () {
                setState(() {});
              },
              child: const CommentsPage());
        },
        fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    final post = postHandler.post;
    final npost = postHandler.npost;

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
          SizedBox(
            height: 500,
            width: 500,
            child: (post != null && npost != null)
                ? CardHolderInherit(
                    currentPost: post,
                    nextPost: npost,
                    child: const CardHolder(),
                    callback: (event) {
                      switch (event) {
                        case CardEvent.swipeLeft:
                          postHandler.nextPost();
                          break;
                        case CardEvent.swipeRight:
                          postHandler.previousPost();
                          break;
                        default:
                      }
                      setState(() {});
                    },
                  )
                : const CircularProgressIndicator(),
          ),
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
              )),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.circle_notifications_rounded),
              label: "Notifications",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "Profile Page",
              backgroundColor: Colors.blue),
        ],
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

class CardHolderInherit extends InheritedWidget {
  final Post currentPost;
  final Post nextPost;
  final void Function(CardEvent)? callback;

  const CardHolderInherit({
    Key? key,
    required Widget child,
    required this.currentPost,
    required this.nextPost,
    this.callback,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(CardHolderInherit oldWidget) {
    return currentPost != oldWidget.currentPost ||
        nextPost != oldWidget.nextPost;
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
