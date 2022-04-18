class DbRoutes{
  static const posts = 'post';
  static const users = 'users';
  static const comments = 'comments';

  static String postData(String id) => '$posts/$id';
  static String userData(String id) => '$users/$id';
  static String commentData(String id) => '$comments/$id';

}