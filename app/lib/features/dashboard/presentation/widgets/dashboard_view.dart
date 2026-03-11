import 'package:flutter/material.dart';
import 'profile_header.dart';
import 'stats_card.dart';
import 'streak_card.dart';
import 'quick_actions.dart';
import 'appointment_card.dart';

class DashboardView extends StatelessWidget {
  final VoidCallback? onExploreRequested;

  const DashboardView({
    super.key,
    this.onExploreRequested,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeader(
            name: 'Alex Johnson',
            level: 12,
            status: 'Wellness Warrior',
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              Expanded(
                child: StatsCard(
                  title: 'TOTAL POINTS',
                  value: '2,450',
                  badge: '+150 this week',
                  icon: Icons.monetization_on,
                  color: Color(0xFFE8F8F5),
                  iconColor: Color(0xFF2ECC71),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatsCard(
                  title: 'GLOBAL RANK',
                  value: '#128',
                  badge: 'Top 5%',
                  icon: Icons.public,
                  color: Color(0xFFEAF2F8),
                  iconColor: Color(0xFF3498DB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const StreakCard(
            streakDays: 7,
            progress: 0.7,
            remainingDays: 3,
            badgeTitle: '10-Day Tenacity',
          ),
          const SizedBox(height: 32),
          QuickActions(onFindClinicTap: onExploreRequested),
          const SizedBox(height: 24),
          const AppointmentCard(
            doctorName: 'Dr. Sarah Johnson',
            specialty: 'Cardiologist',
            location: 'City General',
            date: 'Oct 24, 2023',
            time: '02:15 PM',
          ),
          const SizedBox(height: 120), // More space for floating nav
        ],
      ),
    );
  }
}
