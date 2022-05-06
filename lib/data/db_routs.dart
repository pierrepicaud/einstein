class DbRoutes{
  static const posts = '/post';
  static const users = '/users';
  static const comments = '/comments';
  static const _postComments = 'comments';
  static const avatar = '/avatar';
  static const postPic = '/posts';
  static const pictureExtenton = '.png';

  static String postData(String id) => '$posts/$id';
  static String postComments(String id) => '$posts/$id/$_postComments';
  static String postPicture(String id) => '$postPic/$id$pictureExtenton';
  static String userData(String id) => '$users/$id';
  static String userAvatarPicture(String id) => '$avatar/$id$pictureExtenton';
  static String commentData(String id) => '$comments/$id';
}
