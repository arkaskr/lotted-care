import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  final int streakDays;
  final double progress;
  final int remainingDays;
  final String badgeTitle;

  const StreakCard({
    super.key,
    required this.streakDays,
    required this.progress,
    required this.remainingDays,
    required this.badgeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CURRENT STREAK',
                    style: TextStyle(
                      color: Color(0xFF2ECC71),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '$streakDays Days Solid',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('🔥', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2ECC71),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF2ECC71),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.fireplace, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71)),
              minHeight: 12,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              children: [
                TextSpan(text: '$remainingDays more days to unlock the '),
                TextSpan(
                  text: badgeTitle,
                  style: const TextStyle(
                    color: Color(0xFF2ECC71),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' badge!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
