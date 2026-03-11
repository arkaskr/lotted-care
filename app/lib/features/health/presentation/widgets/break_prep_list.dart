import 'package:flutter/material.dart';

class BreakPrepList extends StatelessWidget {
  const BreakPrepList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Next Break Prep',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1B2A),
          ),
        ),
        const SizedBox(height: 16),
        _buildPrepItem(
          icon: Icons.air,
          title: 'Deep Breathing',
          subtitle: 'Scheduled for 10:30 AM',
          actionLabel: 'Queue',
          iconColor: const Color(0xFF2ECC71),
          backgroundColor: const Color(0xFFE8F8F5),
          isHighlighted: true,
        ),
        const SizedBox(height: 12),
        _buildPrepItem(
          icon: Icons.opacity,
          title: 'Hydration Reminder',
          subtitle: 'Drink 250ml water',
          actionLabel: 'Dismiss',
          iconColor: const Color(0xFF34495E),
          backgroundColor: const Color(0xFFEAF2F8),
          isHighlighted: false,
        ),
      ],
    );
  }

  Widget _buildPrepItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionLabel,
    required Color iconColor,
    required Color backgroundColor,
    required bool isHighlighted,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFFE8F8F5).withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHighlighted ? const Color(0xFF2ECC71).withOpacity(0.2) : Colors.grey.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: actionLabel == 'Queue' ? const Color(0xFF2ECC71) : const Color(0xFFEAF2F8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              actionLabel,
              style: TextStyle(
                color: actionLabel == 'Queue' ? Colors.white : const Color(0xFF0D1B2A),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
