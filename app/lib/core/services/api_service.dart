import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  static Future<Map<String, dynamic>> analyzeSymptoms(String symptoms) async {
    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.analyzeSymptomsUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'symptoms': symptoms}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to analyze symptoms: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to backend: $e');
    }
  }
}
