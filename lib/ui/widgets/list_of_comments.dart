import 'package:flutter/material.dart';
import 'i_comments.dart';
import '../screens/s_comments.dart';

class CommentsList extends StatefulWidget {
  const CommentsList({Key? key}) : super(key: key);
  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    final commentdata = CommentListInherit.of(context).comments;
    return ListView(
      children: [
        for (var i = 0; i < commentdata.length; i++)
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
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(commentdata[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                commentdata[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(commentdata[i]['message']),
            ),
          )
      ],
    );
  }
}
