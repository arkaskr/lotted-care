import 'package:flutter/material.dart';

class WeeklyHydrationChart extends StatelessWidget {
  const WeeklyHydrationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Hydration',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D6D7E),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text(
                '2.4L',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '+12%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2ECC71),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Daily average vs last week',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFABB2B9),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('M', 0.5),
                _buildBar('T', 0.4),
                _buildBar('W', 0.7),
                _buildBar('T', 0.9, isHighlight: true),
                _buildBar('F', 0.8),
                _buildBar('S', 0.3),
                _buildBar('S', 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double heightFactor, {bool isHighlight = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 38,
          height: 120 * heightFactor,
          decoration: BoxDecoration(
            color: isHighlight ? const Color(0xFF2ECC71) : const Color(0xFF2ECC71).withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isHighlight ? const Color(0xFF0D1B2A) : const Color(0xFFABB2B9),
          ),
        ),
      ],
    );
  }
}
