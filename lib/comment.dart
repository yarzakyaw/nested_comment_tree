import 'package:nested_comment_tree/user.dart';

class Comment {
  final int id;
  final User user;
  final String content;
  final String timestamp;
  final List<Comment>? replies;

  Comment({
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: User.fromJson(json['user']),
      content: json['comment'],
      timestamp: json['timestamp'],
      replies:
          (json['replies'] as List?)?.map((e) => Comment.fromJson(e)).toList(),
    );
  }
}
