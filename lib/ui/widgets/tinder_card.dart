import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/data/main_screen/modules/card_events.dart';
import 'package:einstein/data/main_screen/modules/post.dart';
import 'package:einstein/ui/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    Key? key,
    required this.color,
    required this.post,
  }) : super(key: key);

  //On error remove
  final Color color;
  final Post post;
  // final tweet;

  @override
  Widget build(BuildContext context) {
    final inherit =
        context.getElementForInheritedWidgetOfExactType<CardHolderInherit>()!.widget
            as CardHolderInherit;
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
      child: Container(
          color: color,
          child: TinderCardContent(
            post: post,
          )),
    );
  }
}

class TinderCardContent extends StatelessWidget {
  final Post post;
  // TODO: implement userlogic
  // final UserLogic userLogic = HUser();

  const TinderCardContent({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: user logic implement get user by ID
    // final Account user = userLogic.getUserByID(post.author);
    final Account user = Account(userName: 'Pepega');
    // final String avatar = userLogic.getAvatarUrl(user.accPicId);
    final String avatar =
        'https://yt3.ggpht.com/ytc/AKedOLSIDMkTVcRmPtZlIyej4HC20Iaj4iemzLIUkmn8=s900-c-k-c0x00ffffff-no-rj';
    final String postPic =
        'https://96krock.com/wp-content/uploads/sites/61/2019/08/Toilet.jpg';

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: CircleAvatar(
                    radius: 20, backgroundImage: NetworkImage(avatar)),
              ),
              Text(user.userName),
            ],
          ),
          if (post.text != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.text!),
            ),
          // TODO: backend for loading images
          if (post.picId != null) Image(image: NetworkImage(postPic)),
        ],
      ),
    );
  }
}
