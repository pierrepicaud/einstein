import 'package:einstein/logic/h_comments.dart';
import 'package:einstein/ui/widgets/list_of_comments.dart';
import 'package:flutter/material.dart';
import 'package:einstein/ui/widgets/i_comments.dart';
import 'package:comment_box/comment/comment.dart';

class CommentsScreen extends StatefulWidget {
  final String postid;
  final String avatarUrl;
  const CommentsScreen({
    Key? key,
    required this.avatarUrl,
    required this.postid,
  }) : super(key: key);
  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final String postid;
  late final HComments commentHandler;
  late final String avatarUrl;
  void listner() => setState(() {});

  @override
  void initState() {
    super.initState();
    postid = widget.postid;
    avatarUrl = widget.avatarUrl;
    commentHandler = HComments(postID: postid);
    commentHandler.addListener(listner);
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: CommentBox(
          userImage: avatarUrl,
          child: FutureBuilder<List<Map<String, String>>>(
            future: commentHandler.commentsList,
            builder: (context, snapshot) {
              if (snapshot.data == null) return const CircularProgressIndicator();
              return CommentListInherit(
                  comments: snapshot.data!,
                  postid: postid,
                  child: const CommentsList());
            },
          ),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              commentHandler.addComment(commentController.text);
              commentController.clear();
              FocusScope.of(context).unfocus();
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Theme.of(context).dividerColor),
        ));
  }
}
