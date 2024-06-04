import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:health_app_1/presentation/component/colors.dart';

class PedometerGraph extends CustomPainter {
  final int goalSteps;
  final int currentSteps;

  PedometerGraph({
    super.repaint,
    required this.goalSteps,
    required this.currentSteps,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - (paint.strokeWidth / 2);

    const startAngle = 135 * (pi / 180);
    const sweepAngle = 270 * (pi / 180);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    final angle = currentSteps > goalSteps ? sweepAngle : sweepAngle * (currentSteps / goalSteps);

    paint.color = primary;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      angle,
      false,
      paint,
    );

    paint.color = Colors.grey.shade400;
    paint.strokeWidth = 5;
    radius -= 25;

    final path = Path();
    path.addArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
    );

    const double dashSpace = 20;
    double distance = 0;

    for (ui.PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        final Path extractPath = measurePath.extractPath(distance, distance);
        canvas.drawPath(extractPath, paint);
        distance += dashSpace;
      }
      distance = 0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
