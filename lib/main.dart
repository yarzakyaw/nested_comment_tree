import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';
import 'package:nested_comment_tree/comment_tree_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      home: const CommentTreeScreen(),
    );
  }
}
