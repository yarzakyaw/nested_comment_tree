import 'package:flutter/material.dart';
import 'package:nested_comment_tree/comment.dart';
import 'package:nested_comment_tree/utils.dart';

void showReplyTextField(
  BuildContext context,
  Comment parentComment,
  ValueNotifier<List<Comment>> commentsNotifier,
) {
  final textController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder:
        (context) => Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              TextField(controller: textController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (textController.text.trim().isNotEmpty) {
                        addReply(
                          parentComment,
                          textController.text.trim(),
                          commentsNotifier,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
  );
}
