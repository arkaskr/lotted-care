import 'package:flutter/material.dart';
import 'hydration_chart.dart';
import 'circular_metric_card.dart';
import 'insights_track_card.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const WeeklyHydrationChart(),
          const SizedBox(height: 24),
          Row(
            children: const [
              Expanded(
                child: CircularMetricCard(
                  title: 'Posture',
                  subtitle: 'Great Alignment',
                  valueText: '75%',
                  progress: 0.75,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: CircularMetricCard(
                  title: 'Micro Breaks',
                  subtitle: 'Keep moving!',
                  valueText: '4/10',
                  progress: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const InsightsTrackCard(
            icon: Icons.water_drop_rounded,
            title: 'Hydration Level',
            value: '6/8 cups',
            progress: 0.75,
            tip: 'Drink 2 more cups to hit your daily goal!',
          ),
          const SizedBox(height: 16),
          const InsightsTrackCard(
            icon: Icons.air,
            title: 'Deep Breathing',
            value: '12/15 mins',
            progress: 0.8,
            tip: 'Consistency is key. Great job today!',
            iconBackgroundColor: Color(0xFFE8F8F5),
          ),
          const SizedBox(height: 120), // Space for floating nav
        ],
      ),
    );
  }
}
