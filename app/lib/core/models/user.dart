class User {
  final String id;
  final String name;
  final String email;
  final int? age;
  final int totalPoints;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.totalPoints = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'],
      totalPoints: json['totalPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'totalPoints': totalPoints,
    };
  }
}
