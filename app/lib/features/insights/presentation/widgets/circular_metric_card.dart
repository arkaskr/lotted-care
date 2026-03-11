import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularMetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String valueText;
  final double progress;

  const CircularMetricCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.valueText,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CustomPaint(
                  painter: _MetricRingPainter(
                    progress: progress,
                    backgroundColor: Colors.grey.withOpacity(0.08),
                    progressColor: const Color(0xFF2ECC71),
                  ),
                ),
              ),
              Text(
                valueText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFABB2B9),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRingPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  _MetricRingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 8.0;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

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
