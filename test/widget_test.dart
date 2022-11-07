import 'package:einstein/logic/h_comments.dart';
import 'package:einstein/logic/h_post.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_data.dart';

void main() {
  test('h_comments test', () async {
    final handler = HComments(
      MockComment(),
      MockUser(MockAccount()),
      postID: 'asdf',
    );
    final comments = handler.postID;
    expect(comments.isNotEmpty, true);
  });
  test('h_post test', () async {
    final handler = HPost(
      MockPosts(),
      MockAccount(),
      MockPicture(),
    );

    final post = await handler.fetchPostByID('asdf');
    
    expect(post!.author, 'asdffgsfgsfgjhjhgashdg');
    expect(post.date, 123413);
  });
}
