import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularTimer extends StatelessWidget {
  final String timeText;
  final String statusText;
  final double progress;

  const CircularTimer({
    super.key,
    required this.timeText,
    required this.statusText,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 240,
            height: 240,
            child: CustomPaint(
              painter: TimerPainter(
                progress: progress,
                backgroundColor: Colors.grey.withOpacity(0.1),
                progressColor: const Color(0xFF2ECC71),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timeText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0D1B2A).withOpacity(0.6),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  TimerPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 12.0;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
