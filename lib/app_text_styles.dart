import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';

class AppTextStyles {
  static TextStyle headlineSmall(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onPrimary,
    fontFamily: 'Roboto',
  );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
    fontFamily: 'Roboto',
  );

  static TextStyle bodyMedium(BuildContext context) =>
      TextStyle(fontSize: 14, color: AppColors.onSurface, fontFamily: 'Roboto');

  static TextStyle bodySmall(BuildContext context) =>
      TextStyle(fontSize: 12, color: AppColors.greyText, fontFamily: 'Roboto');

  static TextStyle linkText(BuildContext context) => TextStyle(
    fontSize: 14,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );
}
