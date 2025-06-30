import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_clinicz_app/models/authenthication_model.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/login_page.dart';

class AuthenticationServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/user";

  // METHOD GET TOKEN
  String? _extractTokenFromCookie(String cookie) {
    final regex = RegExp(r'auth_token=([^;]+)');
    final match = regex.firstMatch(cookie);
    return match?.group(1);
  }

  // METHOD LOGIN ACCOUNT
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
  Future<Map<String, dynamic>> registerAccount(
    String userName,
    String email,
    String password,
    String gender,
    String dateOfBirth,
    File photoProfile,
  ) async {
    try {
      var uri = Uri.parse('$baseUrl/signup');
      var request = http.MultipartRequest('POST', uri);

      request.fields['username'] = userName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['gender'] = gender;
      request.fields['dateOfBirth'] = dateOfBirth;

      if (photoProfile.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', photoProfile.path),
        );
      } else {
        return {"status": "error", "message": "Gambar tidak ditemukan."};
      }
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();
      return jsonDecode(responseBody);
    } catch (e) {
      return {
        "status": "error",
        "message": "Terjadi kesalahan saat register: $e",
      };
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

  // METHOD UPDATE PASSWORD
  Future updatePassword(String currentPass, String newPass) async {
    Map<String, dynamic> requestData = {
      "currentPassword": currentPass,
      "newPassword": newPass,
    };

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) throw Exception("Token tidak ditemukan.");

    final response = await http.put(
      Uri.parse('$baseUrl/update-password'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'auth_token=$token',
      },
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Gagal mengubah password: ${response.statusCode}");
    }
  }

  // METHOD DELETE ACCOUNT
  Future deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {}

    final response = await http.delete(
      Uri.parse('$baseUrl/delete-account'),
      headers: {'Cookie': 'auth_token=$token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Gagal menghapus akun: ${response.statusCode}");
    }
  }

  // METHOD LOGOUT
  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {}
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'auth_token=$token',
        },
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove("token");
        Get.offAll(() => LoginPage());
      } else {
        throw Exception("Failed to logout.");
      }
    } catch (e) {
      Get.snackbar("Logout Failed", e.toString());
    }
  }
}
