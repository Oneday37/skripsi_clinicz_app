import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_clinicz_app/models/authenthication_model.dart';

class AuthenticationServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/user";

  // METHOD GET TOKEN
  String? _extractTokenFromCookie(String cookie) {
    final regex = RegExp(r'auth_token=([^;]+)');
    final match = regex.firstMatch(cookie);
    return match?.group(1);
  }

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

  // METHOD REGISTER NEW ACCOUNT
  Future<String> registerAccount(
    String userName,
    String email,
    String password,
    String gender,
    DateTime dateOfBirth,
  ) async {
    Map<String, dynamic> requestData = {
      "username": userName,
      "email": email,
      "password": password,
      "gender": gender,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "profileImage": "",
    };

    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Gagal daftar: ${response.body}");
    }
  }

  // METHOD GET PROFILE
  Future<AuthenthicationModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {}

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Cookie': 'auth_token=$token'},
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return AuthenthicationModel.fromJson(responseBody);
    } else {
      throw Exception("Failed to load data");
    }
  }

  // METHOD UPDATE PROFILE

  // METHOD UPDATE PASSWORD

  // METHOD DELETE ACCOUNT

  // METHOD LOGOUT
  Future logoutUser() async {
    final response = await http.post(Uri.parse("$baseUrl/logout"));

    try {
      if (response.statusCode == 200) {
        print(response.body);
        print("Berhasil keluar dari akun");
        return true;
      } else {
        print("Gagal logout: ${response.statusCode} - ${response.body}");
        throw Exception("Failed to logout");
      }
    } catch (e) {
      print("Terjadi kesalahan saat logout: $e");
      return false;
    }
  }
}
