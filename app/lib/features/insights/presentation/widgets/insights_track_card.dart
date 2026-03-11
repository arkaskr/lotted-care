import 'package:flutter/material.dart';

class InsightsTrackCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final double progress;
  final String tip;
  final Color iconBackgroundColor;

  const InsightsTrackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.progress,
    required this.tip,
    this.iconBackgroundColor = const Color(0xFFE8F8F5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFF2ECC71), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34495E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFF2F3F4),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.info_outline, color: Color(0xFFABB2B9), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tip,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFABB2B9),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
