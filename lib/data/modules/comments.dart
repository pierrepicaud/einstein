import 'dart:convert';

// generated with "dart data class generator"
// extention for vs code

class Comments {
  String author;
  String text;
  String replyTo;
  int date;
  Comments({
    required this.author,
    required this.text,
    required this.replyTo,
    required this.date,
  });

  Comments copyWith({
    String? author,
    String? text,
    String? replyTo,
    int? date,
  }) {
    return Comments(
      author: author ?? this.author,
      text: text ?? this.text,
      replyTo: replyTo ?? this.replyTo,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'author': author});
    result.addAll({'text': text});
    result.addAll({'replyTo': replyTo});
    result.addAll({'date': date});

    return result;
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
      author: map['author'] ?? '',
      text: map['text'] ?? '',
      replyTo: map['replyTo'] ?? '',
      date: map['date']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comments.fromJson(String source) =>
      Comments.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comments(author: $author, text: $text, replyTo: $replyTo, date: $date)';
  }
}
