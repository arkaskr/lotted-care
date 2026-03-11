import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models/activity_session.dart';
import '../../../../core/services/activity_service.dart';

class SessionExecutionPage extends StatefulWidget {
  final ActivitySession session;

  const SessionExecutionPage({super.key, required this.session});

  @override
  State<SessionExecutionPage> createState() => _SessionExecutionPageState();
}

class _SessionExecutionPageState extends State<SessionExecutionPage> {
  int _currentActivityIndex = 0;
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isPaused = false;
  late List<Activity> _updatedActivities;

  @override
  void initState() {
    super.initState();
    _updatedActivities = List.from(widget.session.activities);
    if (widget.session.activities.isNotEmpty) {
      _startActivity(0);
    }
  }

  void _startActivity(int index) {
    setState(() {
      _currentActivityIndex = index;
      _remainingSeconds = widget.session.activities[index].duration * 60;
      _isPaused = false;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timer?.cancel();
            _nextActivity();
          }
        });
      }
    });
  }

  void _dismissActivity() {
    setState(() {
      _updatedActivities[_currentActivityIndex] =
          _updatedActivities[_currentActivityIndex].copyWith(dismissed: true);
    });
    _nextActivity();
  }

  void _nextActivity() {
    if (_currentActivityIndex < widget.session.activities.length - 1) {
      _startActivity(_currentActivityIndex + 1);
    } else {
      _finishSession();
    }
  }

  Future<void> _finishSession() async {
    _timer?.cancel();
    if (widget.session.id.isNotEmpty) {
      await ActivityService.updateSessionStatus(
        widget.session.id,
        true,
        activities: _updatedActivities,
      );
    }
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Session Complete!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Amazing work! You\'ve completed all your planned activities.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to dashboard
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('BACK TO HOME'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentActivity = widget.session.activities[_currentActivityIndex];
    final progress = 1 - (_remainingSeconds / (currentActivity.duration * 60));
    final isWork = currentActivity.type == 'work';

    return Scaffold(
      backgroundColor: isWork
          ? const Color(0xFFF8FBFF)
          : const Color(0xFFFDF7F7),
      appBar: AppBar(
        title: Text(
          'Session Active',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWork ? 'WORK PHASE' : 'REST PHASE',
              style: TextStyle(
                color: isWork ? const Color(0xFF2ECC71) : Colors.red,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentActivity.activityName,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D1B2A),
              ),
            ),
            const SizedBox(height: 48),
            // Circular Timer
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: isWork
                        ? const Color(0xFFE8F8F5)
                        : const Color(0xFFFEE2E2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isWork ? const Color(0xFF2ECC71) : Colors.red,
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  _formatTime(_remainingSeconds),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0D1B2A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: _isPaused
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  color: const Color(0xFF0D1B2A),
                  onTap: () => setState(() => _isPaused = !_isPaused),
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  icon: Icons.close_rounded,
                  color: Colors.redAccent.withOpacity(0.1),
                  iconColor: Colors.redAccent,
                  onTap: _dismissActivity,
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  icon: Icons.skip_next_rounded,
                  color: Colors.grey[300]!,
                  iconColor: Colors.black54,
                  onTap: _nextActivity,
                ),
              ],
            ),
            const SizedBox(height: 48),
            // Activity Queue
            _buildActivityQueue(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 36),
      ),
    );
  }

  Widget _buildActivityQueue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'COMING UP NEXT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.session.activities.length,
            itemBuilder: (context, index) {
              if (index <= _currentActivityIndex) return const SizedBox();
              final act = widget.session.activities[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      act.activityName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${act.duration} mins',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
