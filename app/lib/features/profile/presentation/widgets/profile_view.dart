import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2ECC71), width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop'),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ECC71),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'lotted_care',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Age: 28 • Member since 2023',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8F8F5),
                      foregroundColor: const Color(0xFF2ECC71),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          // Wellness Activity Section
          const _SectionHeader(icon: Icons.auto_graph_rounded, title: 'Wellness Activity'),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _StatCard(
                  title: 'DAILY STREAK',
                  value: '15 days',
                  trend: '+2% vs last week',
                  icon: Icons.local_fire_department_rounded,
                  iconColor: Colors.orange,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'TOTAL SESSIONS',
                  value: '120',
                  trend: '+5% vs last week',
                  icon: Icons.push_pin_rounded,
                  iconColor: Color(0xFF2ECC71),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'HYDRATION GOALS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Text(
                      '8/10 cups',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2ECC71),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 8,
                    backgroundColor: Color(0xFFF0F4F8),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBadge(Icons.wb_sunny_rounded, true),
              _buildBadge(Icons.water_drop_rounded, true),
              _buildBadge(Icons.emoji_events_rounded, true),
              _buildBadge(Icons.lock_rounded, false),
            ],
          ),

          const SizedBox(height: 32),
          // Health & Medical Section
          const _SectionHeader(title: 'Health & Medical'),
          const SizedBox(height: 16),
          _buildSettingsList([
             _SettingItem(
              icon: Icons.add_box_rounded,
              iconColor: Colors.blue,
              title: 'Saved Clinics',
              subtitle: '3 locations saved',
            ),
             _SettingItem(
              icon: Icons.search_rounded,
              iconColor: Colors.orange,
              title: 'Recent Symptom Searches',
              subtitle: 'Fatigue, Low Vitamin D',
            ),
             _SettingItem(
              icon: Icons.calendar_month_rounded,
              iconColor: Colors.purple,
              title: 'Appointment History',
              subtitle: 'Next: Dec 12, 2023',
            ),
          ]),

          const SizedBox(height: 32),
          // App Settings Section
          const _SectionHeader(title: 'App Settings'),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: const Icon(Icons.notifications_rounded, color: Color(0xFF5D6D7E)),
                  title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Health alerts & reminders', style: TextStyle(fontSize: 12)),
                  trailing: Switch.adaptive(
                    value: _notificationsEnabled,
                    activeColor: const Color(0xFF2ECC71),
                    onChanged: (v) => setState(() => _notificationsEnabled = v),
                  ),
                ),
                Divider(height: 1, color: Colors.grey[100]),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: const Icon(Icons.timer_rounded, color: Color(0xFF5D6D7E)),
                  title: const Text('Meditation Timer', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('10 mins default', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildSettingsList([
            const _SettingItem(icon: Icons.help_outline_rounded, title: 'Help Center'),
            const _SettingItem(icon: Icons.info_outline_rounded, title: 'About lotted_care'),
            const _SettingItem(icon: Icons.description_outlined, title: 'Terms & Privacy'),
          ]),

          const SizedBox(height: 32),
          // Log Out Button
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              label: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent.withOpacity(0.05),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, bool isActive) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F8F5) : const Color(0xFFF8FBFF),
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? const Color(0xFF2ECC71).withOpacity(0.2) : Colors.transparent,
        ),
      ),
      child: Icon(
        icon,
        color: isActive ? const Color(0xFF2ECC71) : Colors.grey[300],
        size: 28,
      ),
    );
  }

  Widget _buildSettingsList(List<_SettingItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.iconColor?.withOpacity(0.1) ?? Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.iconColor ?? const Color(0xFF5D6D7E), size: 22),
                ),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: item.subtitle != null ? Text(item.subtitle!, style: const TextStyle(fontSize: 12)) : null,
                trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFABB2B9)),
                onTap: () {},
              ),
              if (index < items.length - 1)
                Divider(height: 1, color: Colors.grey[100], indent: 64),
            ],
          );
        }),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData? icon;
  final String title;

  const _SectionHeader({this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: const Color(0xFF2ECC71), size: 22),
          const SizedBox(width: 8),
        ],
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1B2A),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  letterSpacing: 0.5,
                ),
              ),
              Icon(icon, color: iconColor, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            trend,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF2ECC71),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;

  const _SettingItem({
    required this.icon,
    this.iconColor,
    required this.title,
    this.subtitle,
  });
}
