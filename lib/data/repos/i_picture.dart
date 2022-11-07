abstract class IPicture {
  String get baseAvatarID;

  Future<String> getAvatarURL(String picID);

  Future<String> getPostPictureURL(String picID);

  void uploadAvatar(String filePath);

  void uploadPostPicture(String postID, String filePath);
}
