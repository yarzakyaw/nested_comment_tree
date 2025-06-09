import 'package:nested_comment_tree/comment.dart';

List<Comment> updateCommentContent(
  List<Comment> comments,
  Comment target,
  String newContent,
) {
  return comments.map((comment) {
    if (comment.id == target.id) {
      return Comment(
        id: comment.id,
        user: comment.user,
        content: newContent,
        timestamp: comment.timestamp,
        replies: comment.replies,
      );
    } else if (comment.replies != null && comment.replies!.isNotEmpty) {
      return Comment(
        id: comment.id,
        user: comment.user,
        content: comment.content,
        timestamp: comment.timestamp,
        replies: updateCommentContent(comment.replies!, target, newContent),
      );
    }
    return comment;
  }).toList();
}
