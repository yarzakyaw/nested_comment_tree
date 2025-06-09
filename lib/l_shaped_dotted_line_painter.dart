import 'package:flutter/material.dart';
import 'package:nested_comment_tree/app_colors.dart';

class LShapedDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint =
        Paint()
          ..color = AppColors.greyText.withOpacity(0.9)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

    double dashWidth = 4.0;
    double dashSpace = 4.0;

    double startY = 0;
    double verticalHeight = size.height * 0.5;

    while (startY < verticalHeight) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    startY = verticalHeight;
    double horizontalLength = 10.0;
    double horizontalY = verticalHeight;

    while (startY < verticalHeight + dashWidth) {
      canvas.drawLine(
        Offset(0, horizontalY),
        Offset(horizontalLength, horizontalY),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
