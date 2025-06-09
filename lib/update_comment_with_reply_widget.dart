import 'package:nested_comment_tree/comment.dart';

List<Comment> updateCommentsWithReply(
  List<Comment> comments,
  Comment parent,
  Comment newReply,
) {
  return comments.map((comment) {
    if (comment.id == parent.id) {
      return Comment(
        id: comment.id,
        user: comment.user,
        content: comment.content,
        timestamp: comment.timestamp,
        replies: [...(comment.replies ?? []), newReply],
      );
    } else if (comment.replies != null && comment.replies!.isNotEmpty) {
      return Comment(
        id: comment.id,
        user: comment.user,
        content: comment.content,
        timestamp: comment.timestamp,
        replies: updateCommentsWithReply(comment.replies!, parent, newReply),
      );
    }
    return comment;
  }).toList();
}
