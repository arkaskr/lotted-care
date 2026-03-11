import 'package:flutter/material.dart';
import '../widgets/dashboard_view.dart';
import '../../../health/presentation/widgets/health_view.dart';
import '../../../insights/presentation/widgets/insights_view.dart';
import '../../../explore/presentation/widgets/explore_view.dart';
import '../../../profile/presentation/widgets/profile_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _views = [
      DashboardView(onExploreRequested: () => setState(() => _selectedIndex = 3)),
      const HealthView(),
      const InsightsView(),
      const ExploreView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: IndexedStack(
              index: _selectedIndex,
              children: _views,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Container(
              height: 64,
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
                  _buildNavItem(0, Icons.home_filled),
                  _buildNavItem(1, Icons.favorite_rounded),
                  _buildNavItem(2, Icons.bar_chart_rounded),
                  _buildNavItem(3, Icons.explore_rounded),
                  _buildNavItem(4, Icons.person_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
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
