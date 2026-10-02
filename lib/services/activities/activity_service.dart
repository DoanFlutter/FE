import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/api.dart';
import '../../models/activity_model.dart';
import '../auth/auth_service.dart';

class ActivityService {
  static Future<List<Activity>> getActivities({
    String? status,
    String? search,
    String? categoryId,
  }) async {
    final token = await AuthService().getAccessToken();

    final params = <String, String>{
      if (status != null) 'status': status,
      if (search != null && search.isNotEmpty) 'search': search,
      if (categoryId != null) 'categoryId': categoryId,
    };

    final uri = Uri.parse(Api.getActivities)
        .replace(queryParameters: params.isEmpty ? null : params);

    final response = await http
        .get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 401) {
      throw Exception('Phiên đăng nhập đã hết hạn');
    }

    if (response.statusCode != 200) {
      throw Exception('Không thể tải hoạt động (${response.statusCode})');
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    final List list = decoded is List ? decoded : (decoded['data'] ?? []);

    return list
        .map((e) => Activity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Activity>> getOngoingActivities() =>
      getActivities(status: 'ongoing');

  static Future<List<Activity>> getCompletedActivities() =>
      getActivities(status: 'completed');

  static Future<List<Activity>> getCancelledActivities() =>
      getActivities(status: 'cancelled');
}
