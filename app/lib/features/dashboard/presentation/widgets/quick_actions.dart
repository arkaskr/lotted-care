import 'package:flutter/material.dart';
import '../../../symptom_checker/presentation/pages/symptom_selection_page.dart';
import '../../../health/presentation/pages/create_session_page.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback? onFindClinicTap;

  const QuickActions({super.key, this.onFindClinicTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1B2A),
          ),
        ),
        const SizedBox(height: 16),
        _buildActionItem(
          icon: Icons.calendar_today_rounded,
          title: 'Plan Session',
          subtitle: 'Create activities & work blocks',
          iconColor: Colors.blue,
          backgroundColor: const Color(0xFFEBF5FB),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateSessionPage()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          icon: Icons.medical_services,
          title: 'Check Symptoms',
          subtitle: 'AI-powered health assessment',
          iconColor: Colors.orange,
          backgroundColor: const Color(0xFFFEF5E7),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SymptomSelectionPage()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionItem(
          icon: Icons.location_on,
          title: 'Find Clinic',
          subtitle: 'Locate specialists near you',
          iconColor: Colors.green,
          backgroundColor: const Color(0xFFE8F8F5),
          onTap: onFindClinicTap,
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color backgroundColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
