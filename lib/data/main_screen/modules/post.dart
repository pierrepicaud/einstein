import 'dart:convert';

// generated with "dart data class generator"
// extention for vs code

class Post {
  final String author;
  final int date;
  final String? text;
  final String? picId;
  final String? repostFrom;
  final int sharedCount;
  final int likeCount;
  final int commentCount;
  final List<String>? likedBy;
  final List<String>? comments;

  const Post({
    required this.author,
    required this.date,
    this.text,
    this.picId,
    this.repostFrom,
    this.sharedCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.likedBy,
    this.comments,
  });

  Post copyWith({
    String? id,
    String? author,
    int? date,
    String? text,
    String? picId,
    String? repostFrom,
    int? sharedCount,
    int? likeCount,
    int? commentCount,
    List<String>? likedBy,
    List<String>? comments,
  }) {
    return Post(
      author: author ?? this.author,
      date: date ?? this.date,
      text: text ?? this.text,
      picId: picId ?? this.picId,
      repostFrom: repostFrom ?? this.repostFrom,
      sharedCount: sharedCount ?? this.sharedCount,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      likedBy: likedBy ?? this.likedBy,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'author': author});
    result.addAll({'date': date});
    if (text != null) {
      result.addAll({'text': text});
    }
    if (picId != null) {
      result.addAll({'picId': picId});
    }
    if (repostFrom != null) {
      result.addAll({'repostFrom': repostFrom});
    }
    result.addAll({'sharedCount': sharedCount});
    result.addAll({'likeCount': likeCount});
    result.addAll({'commentCount': commentCount});
    if (likedBy != null) {
      result.addAll({'likedBy': likedBy});
    }
    if (comments != null) {
      result.addAll({'comments': comments});
    }

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      author: map['author'] ?? '',
      date: map['date'] ?? 0,
      text: map['text'],
      picId: map['picId'],
      repostFrom: map['repostFrom'],
      sharedCount: map['sharedCount']?.toInt() ?? 0,
      likeCount: map['likeCount']?.toInt() ?? 0,
      commentCount: map['commentCount']?.toInt() ?? 0,
      likedBy: map.containsKey('likedBy')? List<String>.from(map['likedBy']) : null,
      comments: map.containsKey('comments')? List<String>.from(map['comments']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(author: $author, date: $date, text: $text, picId: $picId, repostFrom: $repostFrom, sharedCount: $sharedCount, likeCount: $likeCount, commentCount: $commentCount, likedBy: $likedBy, comments: $comments)';
  }
}
