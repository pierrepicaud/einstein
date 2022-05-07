import 'package:einstein/data/main_screen/modules/card_events.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/logic/authentication/h_user.dart';
import 'package:einstein/logic/main_screen/h_post.dart';
import 'package:einstein/logic/transitions/custom_route.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/home/card_holder.dart';
import 'package:flutter/material.dart';
import 'package:einstein/ui/widgets/mainpage_comments_page.dart';

import 'package:einstein/ui/search/search_page.dart';
// ignore: todo
//TODO: seporate logic from UI

class MainPage extends StatefulWidget {
  static const routeName = "/home";

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final postHandler = HPost();
  final userHandler = HUser();
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

  void addcomment() {}

  void __openSearchPage() async {
    await Navigator.of(context).push(MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return SearchPage();
        },
        fullscreenDialog: true));
  }

  void __openComments(String? postid, String avatarUrl) async {
    if (postid == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return CommentsPage(postid: postid, avatarUrl: avatarUrl);
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 1) {
      return Scaffold(
        body: const SearchPage(),
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
    } else {
      final post = postHandler.post;
      final npost = postHandler.npost;

      return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => postHandler.addPost(),
            tooltip: 'Increment Counter',
            child: const Icon(Icons.add)),
        body: SafeArea(
          child: FutureBuilder<String>(
              future: userHandler.getCurrentAvatarUrl(),
              builder: (context, snapshot) {
                final avatarImageUrl = snapshot.data;
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            FadePageRoute(
                              builder: (context) => const AccountScreen(),
                            ),
                          );
                        },
                        icon: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: (avatarImageUrl == null)
                              ? null
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(avatarImageUrl),
                                ),
                        ),
                      ),
                    ),
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
                                  case CardEvent.swipeUp:
                                  case CardEvent.swipeDown:
                                    if(avatarImageUrl == null) break;
                                    __openComments(postHandler.postID, avatarImageUrl);
                                    break;
                                  case CardEvent.swipeLeft:
                                    postHandler.nextPost();
                                    break;
                                  case CardEvent.swipeRight:
                                    postHandler.likePressed();
                                    break;
                                  default:
                                }
                                setState(() {});
                              },
                            )
                          : const CircularProgressIndicator(),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: <Widget>[
                          TextButton(
                            child: const Icon(Icons.favorite_outline_sharp),
                            onPressed: () {},
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
                              //postHandler.nextPost();
                            },
                          ),
                          Text("${post?.commentCount}"),
                        ],
                      ),
                    ),
                  ],
                );
              }),
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
        color: Colors.blue.shade300,
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
        style: const TextStyle(fontSize: 15),
      ),
    );
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

class SingleComment extends StatelessWidget {
  const SingleComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
