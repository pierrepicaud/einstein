class DbRoutes{
  static const posts = 'post';
  static const users = 'users';
  static const comments = 'comments';
  static const _postComments = 'comments';

  static String postData(String id) => '$posts/$id';
  static String postComments(String id) => '$posts/$id/$_postComments';
  static String userData(String id) => '$users/$id';
  static String commentData(String id) => '$comments/$id';

}