import 'package:einstein/logic/main_screen/h_comments.dart';

import 'mainpage_list_of_comments.dart';
import 'package:flutter/material.dart';
import 'package:einstein/ui/widgets/mainpage_access_to_comments.dart';

import 'package:comment_box/comment/comment.dart';

class CommentsPage extends StatefulWidget {
  final String postid;
  const CommentsPage({
    Key? key,
    required this.postid,
  }) : super(key: key);
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final String postid;
  late final HComments commentHandler;

  void listner() => setState(() {});

  @override
  void initState() {
    super.initState();
    postid = widget.postid;
    commentHandler = HComments(postID: postid);
    commentHandler.addListener(listner);
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          backgroundColor: Colors.blue,
        ),
        body: CommentBox(
          userImage:
              "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: FutureBuilder<List<Map<String, String>>>(
            future: commentHandler.commentsList,
            builder: (context, snapshot) {
              if (snapshot.data == null) return CircularProgressIndicator();
              return CommentListInheritedWidget(
                  comments: snapshot.data!,
                  postid: postid,
                  listener: listner,
                  child: const CommentsList());
            },
          ), //CommentsList(commentdata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              // var value = {
              //   'name': 'New User',
              //   'pic':
              //       'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
              //   'message': commentController.text
              // };
              // value;
              commentHandler.addComment(commentController.text);
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
  }
}
