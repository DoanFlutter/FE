import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api.dart';
import '../../models/user_model.dart';

class AuthService {
  static const String _tokenKey = 'accessToken';
  static const String _userKey = 'user';

  Future<String?> login(String studentCode, String password) async {
    try {
      final response = await http.post(
        Uri.parse(Api.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'student_code': studentCode,
          'password': password,
          'device': 'Flutter',
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(_tokenKey, data['accessToken']);
        await prefs.setString(_userKey, jsonEncode(data['user']));

        return null;
      }

      if (response.statusCode == 401) {
        return body['message'] ?? 'Mã sinh viên hoặc mật khẩu không đúng';
      }

      return body['message'] ?? 'Đã xảy ra lỗi';
    } catch (error) {
      return 'Không thể kết nối đến máy chủ';
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);

    if (raw == null) return null;

    try {
      return UserModel.fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      if (JwtDecoder.isExpired(token)) {
        await logout();
        return false;
      }
    } catch (_) {
      await logout();
      return false;
    }

    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
