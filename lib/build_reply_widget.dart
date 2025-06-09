import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';
import 'package:nested_comment_tree/app_text_styles.dart';
import 'package:nested_comment_tree/app_variables.dart';
import 'package:nested_comment_tree/comment.dart';
import 'package:nested_comment_tree/l_shaped_dotted_line_painter.dart';
import 'package:nested_comment_tree/show_edit_textfield_widget.dart';
import 'package:nested_comment_tree/show_reply_textfield_widget.dart';
import 'package:nested_comment_tree/utils.dart';

Widget buildReplyWidget(
  BuildContext context,
  Comment comment, {
  required int depth,
  required ValueNotifier<List<Comment>> commentsNotifier,
}) {
  final currentUserId = 61;
  final isCurrentUser = comment.user.id == currentUserId;

  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, top: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (depth > 0)
          Container(
            width: (depth * 20.0).clamp(0, 200),
            child: CustomPaint(
              painter: LShapedDottedLinePainter(),
              child: Container(height: 40),
            ),
          ),
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            comment.user.profilePic != null
                ? comment.user.profilePic.toString()
                : AppVariables.placeHolder,
          ),
          onBackgroundImageError:
              (exception, stackTrace) =>
                  const Icon(Icons.person, color: AppColors.greyText),
          backgroundColor: AppColors.avatarBackground,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.reply,
                            size: 16,
                            color: AppColors.greyText,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              comment.user.name,
                              style: AppTextStyles.titleMedium(context),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatTimestamp(comment.timestamp),
                      style: AppTextStyles.bodySmall(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  comment.content.isEmpty
                      ? 'No content available'
                      : comment.content,
                  style: AppTextStyles.bodyMedium(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    if (depth < 7)
                      RichText(
                        text: TextSpan(
                          text: 'Reply',
                          style: AppTextStyles.linkText(context),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => showReplyTextField(
                                      context,
                                      comment,
                                      commentsNotifier,
                                    ),
                        ),
                      ),
                    if (isCurrentUser) const SizedBox(width: 16),
                    if (isCurrentUser)
                      RichText(
                        text: TextSpan(
                          text: 'Edit',
                          style: AppTextStyles.linkText(context),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => showEditTextField(
                                      context,
                                      comment,
                                      commentsNotifier,
                                    ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
