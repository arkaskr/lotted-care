import 'package:flutter/material.dart';

class FocusModeToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const FocusModeToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F8F5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.do_not_disturb_on, color: Color(0xFF2ECC71), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Focus Mode',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                Text(
                  'Block notifications and distractions',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2ECC71),
          ),
        ],
      ),
    );
  }
}
