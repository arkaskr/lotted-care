import 'package:flutter/material.dart';
import 'circular_timer.dart';
import 'timer_controls.dart';
import 'focus_mode_toggle.dart';
import 'health_stats.dart';
import 'break_prep_list.dart';

class HealthView extends StatefulWidget {
  const HealthView({super.key});

  @override
  State<HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  bool _isFocusMode = false;
  bool _isPlaying = false;
  double _timerProgress = 0.72; // Dummy progress for 25:00

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const CircularTimer(
            timeText: '25:00',
            statusText: 'FOCUSING',
            progress: 0.72,
          ),
          const SizedBox(height: 32),
          TimerControls(
            isPlaying: _isPlaying,
            onPlayPause: () => setState(() => _isPlaying = !_isPlaying),
            onReset: () {},
            onSkip: () {},
          ),
          const SizedBox(height: 40),
          FocusModeToggle(
            value: _isFocusMode,
            onChanged: (val) => setState(() => _isFocusMode = val),
          ),
          const SizedBox(height: 32),
          const Text(
            'Daily Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 16),
          const HealthProgressGrid(),
          const SizedBox(height: 24),
          const IntensityChart(),
          const SizedBox(height: 32),
          const BreakPrepList(),
          const SizedBox(height: 120), // Space for floating nav
        ],
      ),
    );
  }
}
