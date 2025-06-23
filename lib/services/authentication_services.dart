import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices {
  final String baseUrl =
      "https://global-rosanna-gunadarma-university-d9c92241.koyeb.app/user";

  // METHOD GET TOKEN
  String? _extractTokenFromCookie(String cookie) {
    final regex = RegExp(r'auth_token=([^;]+)');
    final match = regex.firstMatch(cookie);
    return match?.group(1);
  }

  // METHOD REGISTER NEW ACCOUNT

  // METHOD LOGIN
  Future<bool> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      final cookie = response.headers['set-cookie'];

      if (cookie != null) {
        final token = _extractTokenFromCookie(cookie);
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          return true;
        }
      }
    }
    return false;
  }

  // METHOD GET PROFILE
  Future<Map<String, dynamic>?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Cookie': 'auth_token=$token'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  // METHOD UPDATE PROFILE

  // METHOD UPDATE PASSWORD

  // METHOD DELETE ACCOUNT

  // METHOD LOGOUT
}
