import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://10.10.10.12:5000';

  static String get analyzeSymptomsUrl => '$baseUrl/api/chat/analyze-symptoms';
}
