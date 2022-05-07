import 'package:flutter/material.dart';
import 'mainpage_access_to_comments.dart';
import 'mainpage_comments_page.dart';

class CommentsList extends StatefulWidget {
  const CommentsList({Key? key}) : super(key: key);
  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    final commentdata = CommentListInheritedWidget.of(context).comments;
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
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(50))),
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
