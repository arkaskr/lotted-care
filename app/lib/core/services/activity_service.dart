import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/api_config.dart';
import '../models/activity_session.dart';
import './auth_service.dart';

class ActivityService {
  static String get baseUrl =>
      dotenv.get('API_BASE_URL', fallback: ApiConfig.baseUrl);

  static Future<Map<String, String>> _getHeaders() async {
    final token = await AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<ActivitySession?> createSession(ActivitySession session) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/activity/create'),
            headers: headers,
            body: jsonEncode(session.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ActivitySession.fromJson(data['session']);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to create session');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ActivitySession>> getSessions(String userId) async {
    try {
      final headers = await _getHeaders();
      final response = await http
          .get(
            Uri.parse('$baseUrl/api/activity/list/$userId'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ActivitySession.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load sessions');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> updateSessionStatus(
    String sessionId,
    bool isCompleted, {
    List<Activity>? activities,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return false;

      final Map<String, dynamic> body = {'isCompleted': isCompleted};
      if (activities != null) {
        body['activities'] = activities.map((a) => a.toJson()).toList();
      }

      final response = await http
          .patch(
            Uri.parse('$baseUrl/api/activity/status/$sessionId'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
