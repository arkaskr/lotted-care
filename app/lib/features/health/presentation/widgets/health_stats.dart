import 'package:flutter/material.dart';

class HealthProgressGrid extends StatelessWidget {
  const HealthProgressGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: ProgressCard(
            icon: Icons.access_time_filled_rounded,
            title: 'HOURS',
            value: '4.2h',
            trend: '↑ 12% from avg',
            iconColor: Color(0xFF2ECC71),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ProgressCard(
            icon: Icons.coffee_rounded,
            title: 'BREAKS',
            value: '6/8',
            trend: '2 left for today',
            iconColor: Color(0xFF2ECC71),
          ),
        ),
      ],
    );
  }
}

class ProgressCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String trend;
  final Color iconColor;

  const ProgressCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.trend,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            trend,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: trend.startsWith('↑') ? const Color(0xFF2ECC71) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class IntensityChart extends StatelessWidget {
  const IntensityChart({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.stacked_line_chart, color: Color(0xFF2ECC71), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'INTENSITY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Text(
                'Mon - Sun',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.4),
                _buildBar(0.6),
                _buildBar(0.9, isHighlight: true),
                _buildBar(0.5),
                _buildBar(0.3),
                _buildBar(0.4),
                _buildBar(0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor, {bool isHighlight = false}) {
    return Container(
      width: 40,
      height: 60 * heightFactor,
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFF2ECC71) : const Color(0xFF2ECC71).withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
