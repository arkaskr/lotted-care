import 'package:flutter/material.dart';
import '../../../../core/models/user.dart';
import '../../../../core/services/auth_service.dart';
import 'profile_header.dart';
import 'stats_card.dart';
import 'streak_card.dart';
import 'quick_actions.dart';
import 'appointment_card.dart';

class DashboardView extends StatefulWidget {
  final VoidCallback? onExploreRequested;

  const DashboardView({super.key, this.onExploreRequested});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final user = await AuthService.getProfile();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      color: const Color(0xFF2ECC71),
      child: SingleChildScrollView(
        physics:
            const AlwaysScrollableScrollPhysics(), // Ensure refresh works even when content is small
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isLoading
                ? const _DashboardLoadingHeader()
                : ProfileHeader(
                    name: _user?.name ?? 'Wellness User',
                    level: 12,
                    status: 'Wellness Warrior',
                  ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'TOTAL POINTS',
                    value: _user?.totalPoints.toString() ?? '0',
                    badge: '+150 this week',
                    icon: Icons.monetization_on,
                    color: const Color(0xFFE8F8F5),
                    iconColor: const Color(0xFF2ECC71),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
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
            QuickActions(onFindClinicTap: widget.onExploreRequested),
            const SizedBox(height: 24),
            const AppointmentCard(
              doctorName: 'Dr. Sarah Johnson',
              specialty: 'Cardiologist',
              location: 'City General',
              date: 'Oct 24, 2023',
              time: '02:15 PM',
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}

class _DashboardLoadingHeader extends StatelessWidget {
  const _DashboardLoadingHeader();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(child: CircularProgressIndicator(color: Color(0xFF2ECC71))),
    );
  }
}
