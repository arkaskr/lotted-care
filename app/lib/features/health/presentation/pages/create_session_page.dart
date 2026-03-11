import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models/activity_session.dart';
import '../../../../core/services/activity_service.dart';
import '../../../../core/services/auth_service.dart';
import 'session_execution_page.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({super.key});

  @override
  State<CreateSessionPage> createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  final TextEditingController _totalDurationController = TextEditingController(
    text: '60',
  );
  final List<Activity> _activities = [];
  bool _isLoading = false;

  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _activityDurationController =
      TextEditingController();
  String _activityType = 'work';

  void _addActivity() {
    final name = _activityNameController.text.trim();
    final duration = int.tryParse(_activityDurationController.text) ?? 15;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an activity name')),
      );
      return;
    }

    setState(() {
      _activities.add(
        Activity(activityName: name, type: _activityType, duration: duration),
      );
      _activityNameController.clear();
      _activityDurationController.clear();
      _activityType = 'work';
    });
  }

  void _removeActivity(int index) {
    setState(() {
      _activities.removeAt(index);
    });
  }

  int get _totalPlannedDuration =>
      _activities.fold(0, (sum, item) => sum + item.duration);

  Future<void> _saveSession() async {
    final totalDuration = int.tryParse(_totalDurationController.text) ?? 60;

    if (_activities.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one activity')),
      );
      return;
    }

    if (_totalPlannedDuration > totalDuration) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Planned activities exceed total session duration'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await AuthService.getUser();
      if (user == null) {
        throw Exception('User not logged in');
      }

      final session = ActivitySession(
        userId: user.id,
        duration: totalDuration,
        activities: _activities,
      );

      final createdSession = await ActivityService.createSession(session);

      if (mounted && createdSession != null) {
        _showSuccessDialog(createdSession);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessDialog(ActivitySession session) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Session Ready!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your health session has been planned. Would you like to start it now?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to dashboard
            },
            child: const Text('LATER', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SessionExecutionPage(session: session),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('START NOW'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        title: Text(
          'Plan Health Session',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0D1B2A),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF0D1B2A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Session Duration'),
            const SizedBox(height: 12),
            _buildDurationInput(),
            const SizedBox(height: 32),
            _buildSectionTitle('Planned Activities'),
            const SizedBox(height: 8),
            _buildDurationProgress(),
            const SizedBox(height: 16),
            ..._activities.asMap().entries.map(
              (entry) => _buildActivityTile(entry.value, entry.key),
            ),
            const SizedBox(height: 24),
            _buildAddActivityForm(),
            const SizedBox(height: 48),
            _buildSaveButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0D1B2A),
      ),
    );
  }

  Widget _buildDurationInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _totalDurationController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Total minutes (e.g. 60)',
          prefixIcon: const Icon(Icons.timer, color: Color(0xFF2ECC71)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          suffixText: 'mins',
          suffixStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildDurationProgress() {
    final total = int.tryParse(_totalDurationController.text) ?? 1;
    final progress = _totalPlannedDuration / total;
    final color = progress > 1.0 ? Colors.red : const Color(0xFF2ECC71);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$_totalPlannedDuration / $total mins planned',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress > 1.0 ? 1.0 : progress,
          backgroundColor: const Color(0xFFE8F8F5),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }

  Widget _buildActivityTile(Activity activity, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8F8F5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: activity.type == 'work'
                  ? const Color(0xFFE8F8F5)
                  : const Color(0xFFFEE7E7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              activity.type == 'work' ? Icons.work_history : Icons.coffee,
              color: activity.type == 'work'
                  ? const Color(0xFF2ECC71)
                  : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.activityName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${activity.duration} mins • ${activity.type.toUpperCase()}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
            onPressed: () => _removeActivity(index),
          ),
        ],
      ),
    );
  }

  Widget _buildAddActivityForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2ECC71).withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add New Activity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2ECC71),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _activityNameController,
            decoration: InputDecoration(
              hintText: 'Activity name (e.g. Cardio)',
              filled: true,
              fillColor: const Color(0xFFF8FBFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _activityDurationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Duration (mins)',
                    filled: true,
                    fillColor: const Color(0xFFF8FBFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _activityType,
                underline: const SizedBox(),
                items: ['work', 'break'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _activityType = val!),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addActivity,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add to Plan'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveSession,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D1B2A),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'CREATE HEALTH SESSION',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
      ),
    );
  }
}
