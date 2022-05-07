import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/main_screen/modules/card_events.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/logic/authentication/h_user.dart';
import 'package:einstein/logic/main_screen/h_post.dart';
import 'package:einstein/ui/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    Key? key,
    required this.color,
    this.post,
  }) : super(key: key);

  //On error remove
  final Color color;
  final Post? post;
  // final tweet;

  @override
  Widget build(BuildContext context) {
    final inherit = context
        .getElementForInheritedWidgetOfExactType<CardHolderInherit>()!
        .widget as CardHolderInherit;
    return Swipable(
      onSwipeLeft: (_) {
        if (inherit.callback != null) {
          inherit.callback!(CardEvent.swipeLeft);
        }
      },
      onSwipeRight: (_) {
        if (inherit.callback != null) {
          inherit.callback!(CardEvent.swipeRight);
        }
      },
      onSwipeDown: (_) {
        if (inherit.callback != null) {
          inherit.callback!(CardEvent.swipeDown);
        }
      },
      onSwipeUp: (_) {
        if (inherit.callback != null) {
          inherit.callback!(CardEvent.swipeUp);
        }
      },
      child: Container(
          color: color,
          child: TinderCardContent(
            post: post,
          )),
    );
  }
}

class TinderCardContent extends StatelessWidget {
  final Post? post;
  // TODO: implement userlogic
  final userLogic = HUser();
  final postLogic = HPost();

  TinderCardContent({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (post == null)
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Opacity(
                      opacity: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Opacity(
                      opacity: 1,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            )
          else
            FutureBuilder<Account>(
              future: userLogic.getUserByID(post!.author),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Opacity(
                            opacity: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (snapshot.data == null)
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: Opacity(
                            opacity: 1,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: FutureBuilder<String>(
                        key: UniqueKey(),
                        future: userLogic.getAvatarUrl(snapshot.data!.accPicId),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return SizedBox(
                              height: 40,
                              width: 40,
                              child: Opacity(
                                opacity: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(snapshot.data!));
                        },
                      ),
                    ),
                    Text(snapshot.data!.userName),
                  ],
                );
              },
            ),
          if (post != null && post!.text != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post!.text!),
            ),
          if (post != null && post!.picId != null)
            FutureBuilder<String>(
              future: postLogic.getPictureUrl(post!.picId!),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    color: Colors.grey,
                  );
                }
                return Image(
                    image: NetworkImage(snapshot.data!), fit: BoxFit.contain);
              },
            ),
        ],
      ),
    );
  }
}
