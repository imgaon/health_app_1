import 'dart:math';

import 'package:flutter/material.dart';

class CircularGraph extends CustomPainter {
  final double targetValue;
  final double currentValue;
  final Color primaryColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularGraph({
    required this.targetValue,
    required this.currentValue,
    required this.primaryColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (paint.strokeWidth / 2);

    canvas.drawCircle(center, radius, paint);

    paint.color = primaryColor;
    final angle = (2 * pi) * (currentValue / targetValue);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
