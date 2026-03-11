class Activity {
  final String activityName;
  final String type; // 'work' or 'break'
  final int duration;
  final int points;
  final bool dismissed;

  Activity({
    required this.activityName,
    required this.type,
    required this.duration,
    this.points = 0,
    this.dismissed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'type': type,
      'duration': duration,
      'points': points,
      'dismissed': dismissed,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activityName: json['activityName'] ?? '',
      type: json['type'] ?? 'work',
      duration: json['duration'] ?? 0,
      points: json['points'] ?? 0,
      dismissed: json['dismissed'] ?? false,
    );
  }

  Activity copyWith({bool? dismissed}) {
    return Activity(
      activityName: activityName,
      type: type,
      duration: duration,
      points: points,
      dismissed: dismissed ?? this.dismissed,
    );
  }
}

class ActivitySession {
  final String id;
  final String userId;
  final int duration;
  final List<Activity> activities;
  final bool isCompleted;
  final DateTime? createdAt;

  ActivitySession({
    this.id = '',
    required this.userId,
    required this.duration,
    required this.activities,
    this.isCompleted = false,
    this.createdAt,
  });

  factory ActivitySession.fromJson(Map<String, dynamic> json) {
    return ActivitySession(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      duration: json['duration'] ?? 0,
      activities:
          (json['activities'] as List?)
              ?.map((a) => Activity.fromJson(a))
              .toList() ??
          [],
      isCompleted: json['isCompleted'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'duration': duration,
      'activities': activities.map((a) => a.toJson()).toList(),
      'isCompleted': isCompleted,
    };
  }
}
