import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';
import 'package:nested_comment_tree/app_text_styles.dart';
import 'package:nested_comment_tree/app_variables.dart';
import 'package:nested_comment_tree/build_reply_widget.dart';
import 'package:nested_comment_tree/comment.dart';
import 'package:nested_comment_tree/l_shaped_dotted_line_painter.dart';
import 'package:nested_comment_tree/show_edit_textfield_widget.dart';
import 'package:nested_comment_tree/show_reply_textfield_widget.dart';
import 'package:nested_comment_tree/utils.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final int depth;
  final Function(Comment) onShowDetails;
  final ValueNotifier<List<Comment>> commentsNotifier;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.depth,
    required this.onShowDetails,
    required this.commentsNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final hasReplies = comment.replies != null && comment.replies!.isNotEmpty;
    final isCurrentUser = comment.user.id == 61;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            radius: 20,
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
          const SizedBox(width: 12.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
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
                        child: Text(
                          comment.user.name,
                          style: AppTextStyles.titleMedium(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatTimestamp(comment.timestamp),
                        style: AppTextStyles.bodySmall(context),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    comment.content.isEmpty
                        ? 'No content available'
                        : comment.content,
                    style: AppTextStyles.bodyMedium(context),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
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
                  if (hasReplies && comment.replies!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: buildReplyWidget(
                        context,
                        comment.replies!.first,
                        depth: depth + 1,
                        commentsNotifier: commentsNotifier,
                      ),
                    ),
                  if (countTotalReplies(comment) > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: _buildActionText(
                            context,
                            'View all ${comment.replies!.length} replies',
                            () => onShowDetails(comment),
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

  Widget _buildActionText(
    BuildContext context,
    String text,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text, style: AppTextStyles.linkText(context)),
    );
  }
}
