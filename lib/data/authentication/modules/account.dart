import 'dart:convert';


class Account{
  final List<String>? follows;
  final List<String>? posts;
  final List<String>? comments;
  final int followersCount;
  final String? accPicId;
  final String userName;

  Account({
    this.follows,
    this.posts,
    this.comments,
    this.followersCount = 0,
    this.accPicId,
    required this.userName,
  });

  Account copyWith({
    List<String>? follows,
    List<String>? posts,
    List<String>? comments,
    int? followersCount,
    String? accPicId,
    String? userName,
  }) {
    return Account(
      follows: follows ?? this.follows,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      followersCount: followersCount ?? this.followersCount,
      accPicId: accPicId ?? this.accPicId,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(follows != null){
      result.addAll({'follows': follows});
    }
    if(posts != null){
      result.addAll({'posts': posts});
    }
    if(comments != null){
      result.addAll({'comments': comments});
    }
    result.addAll({'followersCount': followersCount});
    if(accPicId != null){
      result.addAll({'accPicId': accPicId});
    }
    result.addAll({'userName': userName});
  
    return result;
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      follows: map.containsKey('follows')? List<String>.from(map['follows']) : null,
      posts: map.containsKey('posts')? List<String>.from(map['posts']) : null,
      comments: map.containsKey('comments')? List<String>.from(map['comments']) : null,
      followersCount: map['followersCount']?.toInt() ?? 0,
      accPicId: map['accPicId'],
      userName: map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(follows: $follows, posts: $posts, comments: $comments, followersCount: $followersCount, accPicId: $accPicId, userName: $userName)';
  }
}
