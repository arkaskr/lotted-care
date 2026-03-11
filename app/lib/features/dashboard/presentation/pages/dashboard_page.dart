import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_card.dart';
import '../widgets/streak_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/appointment_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
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
                  const QuickActions(),
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
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 30,
            child: Container(
              height: 64, // Sleeker height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: const Color(0xFF2ECC71).withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2ECC71).withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_filled, 'Home'),
                  _buildNavItem(1, Icons.favorite_rounded, 'Health'),
                  _buildNavItem(2, Icons.bar_chart_rounded, 'Insights'),
                  _buildNavItem(3, Icons.person_rounded, 'Profile'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF2ECC71) : Colors.grey.withOpacity(0.5),
            size: 28,
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFF2ECC71),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
