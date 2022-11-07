import 'package:einstein/data/modules/card_events.dart';
import 'package:einstein/data/repos/constants.dart';
import 'package:einstein/data/repos/d_account.dart';
import 'package:einstein/data/repos/d_picture.dart';
import 'package:einstein/data/repos/d_post.dart';
import 'package:einstein/logic/h_post.dart';
import 'package:einstein/logic/h_user.dart';
import 'package:einstein/ui/screens/s_account.dart';
import 'package:einstein/ui/screens/s_search.dart';
import 'package:einstein/ui/transitions/custom_route.dart';
import 'package:einstein/ui/widgets/card_holder.dart';
import 'package:einstein/ui/theme.dart';
import 'package:einstein/ui/widgets/i_cardholder.dart';
import 'package:flutter/material.dart';
import 'package:einstein/ui/screens/s_comments.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/home";

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final postHandler = HPost(DPosts(), DAccount(), DPicture());
  final userHandler = HUser(DAccount(), DPicture());
  void listener() => setState(() {});
  int currentIndex = 0;
  bool isInit = true;

  @override
  void initState() {
    super.initState();

    postHandler.addListener(listener);
    setAppTheme(context);
  }

  @override
  void dispose() {
    postHandler.removeListener(listener);
    super.dispose();
  }

  void addcomment() {}

  void setAppTheme(BuildContext context) async {
    final user = await userHandler.cUser;
    Provider.of<ThemeProvider>(context, listen: false).setMode(user.isDarkMode);
  }

  void __openComments(String? postid, String avatarUrl) async {
    if (postid == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return CommentsScreen(postid: postid, avatarUrl: avatarUrl);
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 1) {
      return Scaffold(
        body: const SearchScreen(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedIconTheme:
              Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
          unselectedIconTheme:
              Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Home",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: "Search",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.circle_notifications_rounded),
              label: "Notifications",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              label: "Profile Page",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
          ],
        ),
      );
    } else {
      final post = postHandler.post;

      return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => postHandler.addPost(),
            tooltip: 'Increment Counter',
            child: Icon(
              Icons.edit,
              color: Theme.of(context).dividerColor,
            )),
        body: SafeArea(
          child: FutureBuilder<String>(
              future: userHandler.getCurrentAvatarUrl(),
              builder: (context, snapshot) {
                final avatarImageUrl = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
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
                        Center(
                          child: Text(
                            Constants.appName,
                            style: GoogleFonts.varelaRound(
                              fontSize: 34,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 550,
                      width: 500,
                      child: (post != null)
                          ? CardHolderInherit(
                              currentPost: post,
                              child: const CardHolder(),
                              callback: (event) {
                                switch (event) {
                                  case CardEvent.swipeUp:
                                  case CardEvent.swipeDown:
                                    if (avatarImageUrl == null) break;
                                    __openComments(
                                        postHandler.postID, avatarImageUrl);
                                    break;
                                  case CardEvent.swipeLeft:
                                    postHandler.nextPost();
                                    break;
                                  case CardEvent.swipeRight:
                                    postHandler.likePressed();
                                    postHandler.nextPost();
                                    break;
                                  default:
                                }
                                setState(() {});
                              },
                            )
                          : const CircularProgressIndicator(),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedIconTheme:
              Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
          unselectedIconTheme:
              Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Home",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: "Search",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.circle_notifications_rounded),
              label: "Notifications",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              label: "Profile Page",
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
          ],
        ),
      );
    }
  }
}