import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';
import 'package:nested_comment_tree/app_text_styles.dart';
import 'package:nested_comment_tree/build_reply_widget.dart';
import 'package:nested_comment_tree/comment.dart';
import 'package:nested_comment_tree/comment_widget.dart';
import 'package:nested_comment_tree/show_reply_textfield_widget.dart';
import 'package:nested_comment_tree/utils.dart';

class CommentTreeScreen extends StatefulWidget {
  const CommentTreeScreen({super.key});

  @override
  State<CommentTreeScreen> createState() => _CommentTreeScreenState();
}

class _CommentTreeScreenState extends State<CommentTreeScreen> {
  late ValueNotifier<List<Comment>> commentsNotifier;

  @override
  void initState() {
    super.initState();
    final jsonData = [
      {
        "user": {
          "name": "Muhammad Hasnain",
          "profilepic":
              'https://pk-live-21.slatic.net/kf/Se2f55e34b8564356a2c689bb0281777ck.jpg',
          "id": 61,
        },
        "comment": "Hey MashaAllah, Ramadan is going Amazing",
        "id": 4,
        "timestamp": "2025-02-27T05:10:00.000000Z",
        "replies": [
          {
            "user": {
              "name": "M Arslan Ch",
              "profilepic":
                  "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
              "id": 57,
            },
            "comment": "Yes Brother make it More 👏",
            "id": 5,
            "timestamp": "2025-02-26T12:30:00.000000Z",
            "replies": [
              {
                "user": {
                  "name": "Muhammad Hasnain",
                  "profilepic": null,
                  "id": 61,
                },
                "comment": "yup, definately",
                "id": 8,
                "timestamp": "2025-02-27T04:10:00.000000Z",
                "replies": [
                  {
                    "user": {
                      "name": "Abdullah Alvi",
                      "profilepic":
                          "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                      "id": 64,
                    },
                    "comment": "123",
                    "id": 45,
                    "timestamp": "2025-02-27T02:10:00.000000Z",
                    "replies": [],
                  },
                ],
              },
            ],
          },
          {
            "user": {
              "name": "Abdullah Alvi",
              "profilepic":
                  "https://cdn.stocksnap.io/img-thumbs/960w/beach-ocean_A1CZ4UQZDB.jpg",
              "id": 64,
            },
            "comment": "it really is",
            "id": 44,
            "timestamp": "2025-02-26T14:00:00.000000Z",
            "replies": [],
          },
        ],
      },
      {
        "user": {
          "name": "Hamza Asghar",
          "profilepic":
              "https://hips.hearstapps.com/hmg-prod/images/beautiful-oia-royalty-free-image-1570210636.jpg?crop=1xw:0.99953xh;center,top&resize=980:*",
          "id": 59,
        },
        "comment": "it's an interesting activity",
        "id": 6,
        "timestamp": "2025-02-27T05:01:00.000000Z",
        "replies": [
          {
            "user": {"name": "Muhammad Hasnain", "profilepic": null, "id": 61},
            "comment": "hlo, hmza",
            "id": 7,
            "timestamp": "2025-02-25T18:10:00.000000Z",
            "replies": [],
          },
        ],
      },
      {
        "user": {
          "name": "Bin Qasim Masood",
          "profilepic":
              "https://hips.hearstapps.com/hmg-prod/images/beautiful-oia-royalty-free-image-1570210636.jpg?crop=1xw:0.99953xh;center,top&resize=980:*",
          "id": 56,
        },
        "comment": "nice",
        "id": 22,
        "timestamp": "2025-02-24T10:00:00.000000Z",
        "replies": [
          {
            "user": {
              "name": "M Arslan Ch",
              "profilepic": "48gYlJ73hu7Wrj2e2WkPrz09biaR1C39WTQWCiYW.jpg",
              "id": 57,
            },
            "comment": "gg",
            "id": 23,
            "timestamp": "2025-02-24T10:15:00.000000Z",
            "replies": [],
          },
        ],
      },
    ];
    commentsNotifier = ValueNotifier(
      jsonData.map((json) => Comment.fromJson(json)).toList(),
    );
  }

  void _showCommentDetails(
    BuildContext context,
    Comment comment,
    ValueNotifier<List<Comment>> commentsNotifier,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => ValueListenableBuilder<List<Comment>>(
            valueListenable: commentsNotifier,
            builder: (context, comments, child) {
              Comment updatedComment = comments.firstWhere(
                (c) => c.id == comment.id,
                orElse: () => comment,
              );
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.9,
                color: AppColors.background,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 16,
                        right: 16,
                      ),
                      child: _buildDialogContent(
                        context,
                        updatedComment,
                        depth: 0,
                        commentsNotifier: commentsNotifier,
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 28,
                          color: AppColors.greyText,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    Comment comment, {
    required int depth,
    required ValueNotifier<List<Comment>> commentsNotifier,
  }) {
    return Column(
      children: [
        Text(
          'Comment Details - ${comment.user.name}',
          style: AppTextStyles.headlineSmall(
            context,
          ).copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 16),
        _buildDetailRow('Timestamp', formatTimestamp(comment.timestamp)),
        const SizedBox(height: 8),
        _buildDetailRow(
          'Content',
          comment.content.isEmpty ? 'No content available' : comment.content,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            if (comment.replies != null && comment.replies!.isNotEmpty)
              Text(
                'Replies (${countTotalReplies(comment)})',
                style: AppTextStyles.titleMedium(context),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (comment.replies != null && comment.replies!.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.85,
                    maxWidth: MediaQuery.of(context).size.width * 1.85,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: _buildAllReplies(
                      context,
                      comment,
                      depth: depth + 1,
                      commentsNotifier: commentsNotifier,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: AppTextStyles.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium(context),
            softWrap: true,
            maxLines: null,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAllReplies(
    BuildContext context,
    Comment comment, {
    required int depth,
    required ValueNotifier<List<Comment>> commentsNotifier,
  }) {
    List<Widget> replyWidgets = [];
    if (comment.replies != null) {
      for (var reply in comment.replies!) {
        replyWidgets.add(
          buildReplyWidget(
            context,
            reply,
            depth: depth,
            commentsNotifier: commentsNotifier,
          ),
        );
        replyWidgets.addAll(
          _buildAllReplies(
            context,
            reply,
            depth: depth + 1,
            commentsNotifier: commentsNotifier,
          ),
        );
      }
    }
    return replyWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Comment>>(
      valueListenable: commentsNotifier,
      builder: (context, comments, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Comment Tree',
              style: AppTextStyles.headlineSmall(context),
            ),
            backgroundColor: AppColors.primary,
            elevation: 4,
          ),
          body: Container(
            color: AppColors.background,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          comments
                              .map(
                                (comment) => CommentWidget(
                                  comment: comment,
                                  depth: 0,
                                  onShowDetails:
                                      (comment) => _showCommentDetails(
                                        context,
                                        comment,
                                        commentsNotifier,
                                      ),
                                  commentsNotifier: commentsNotifier,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
