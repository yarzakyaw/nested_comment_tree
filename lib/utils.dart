import 'package:flutter/material.dart';
import 'package:nested_comment_tree/comment.dart';
import 'package:nested_comment_tree/update_comment_content_widget.dart';
import 'package:nested_comment_tree/update_comment_with_reply_widget.dart';
import 'package:nested_comment_tree/user.dart';

String formatTimestamp(String timestampString) {
  final timestamp =
      DateTime.parse(
        timestampString,
      ).toUtc().toLocal(); // Convert UTC timestamp to local time
  final now = DateTime.now(); // Get the current local time
  final difference = now.difference(timestamp); // Calculate difference

  debugPrint("Parsed timestamp (Local): $timestamp");
  debugPrint("Current time (Local): $now");
  debugPrint("Difference in Minutes: ${difference.inMinutes}");

  if (difference.isNegative) {
    return "In the future"; // Handles future timestamps
  } else if (difference.inMinutes < 1) {
    return 'Few moments ago'; // Changed from 'Just now'
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 2) {
    return 'Yesterday';
  } else {
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';
  }
}

int countTotalReplies(Comment comment) {
  int total = comment.replies?.length ?? 0;
  if (comment.replies != null) {
    for (var reply in comment.replies!) {
      total += countTotalReplies(reply);
    }
  }
  return total;
}

void addReply(
  Comment parentComment,
  String content,
  ValueNotifier<List<Comment>> commentsNotifier,
) {
  final newReply = Comment(
    id: DateTime.now().millisecondsSinceEpoch,
    user: User(id: 61, name: 'Muhammad Hasnain', profilePic: null),
    content: content,
    timestamp: DateTime.now().toString(),
    replies: [],
  );
  commentsNotifier.value = updateCommentsWithReply(
    commentsNotifier.value,
    parentComment,
    newReply,
  );
}

void editComment(
  Comment comment,
  String newContent,
  ValueNotifier<List<Comment>> commentsNotifier,
) {
  final updatedComments = updateCommentContent(
    commentsNotifier.value,
    comment,
    newContent,
  );
  commentsNotifier.value = [...updatedComments];
}
