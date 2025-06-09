import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';
import 'package:nested_comment_tree/app_text_styles.dart';
import 'package:nested_comment_tree/comment.dart';
import 'package:nested_comment_tree/utils.dart';

void showEditTextField(
  BuildContext context,
  Comment comment,
  ValueNotifier<List<Comment>> commentsNotifier,
) {
  final textController = TextEditingController(text: comment.content);
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    context: context,
    isScrollControlled: true,
    builder:
        (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Edit your comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceVariant,
                  ),
                  maxLines: null,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.bodyMedium(context),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppColors.primary),
                      onPressed: () {
                        if (textController.text.trim().isNotEmpty) {
                          editComment(
                            comment,
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
        ),
  );
}
