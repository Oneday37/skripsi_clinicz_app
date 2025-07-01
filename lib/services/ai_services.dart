import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_clinicz_app/models/disease_prediction_model.dart';
import 'package:skripsi_clinicz_app/models/drug_recommendation_model.dart';

class AIServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/bot";

  // METHOD GET DISEASE PREDICTION
  Future<DiseasePredictionModel?> getPrediction(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final response = await http.post(
      Uri.parse("$baseUrl/predict-penyakit"),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'auth_token=$token',
      },
      body: jsonEncode({'text': message}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final data = body['data'];
      if (data != null && data.isNotEmpty) {
        return DiseasePredictionModel.fromJson(data[0]);
      }
    } else {
      print("Status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
    return null;
  }

  // METHOD DRUG RECOMMENDATION
  Future<List<DrugRecommendationModel>> getDrugRecommendations(
    String namaPenyakit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse("$baseUrl/rekomendasi-obat"),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Cookie': 'auth_token=$token',
      },
      body: jsonEncode({'penyakit': namaPenyakit}),
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> drugRecommendationList = responseBody["data"];
        final result =
            drugRecommendationList
                .map((item) => DrugRecommendationModel.fromJson(item))
                .toList();
        return result;
      } catch (e) {
        print("Gagal parsing JSON: $e");
        throw Exception("Parsing gagal");
      }
    } else {
      print("Status: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception("Gagal mengambil data dari server");
    }
  }

  // METHOD CHATBOT
  Future chatBotGemini(String message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse("$baseUrl/chat"),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Cookie': 'auth_token=$token',
        },
        body: jsonEncode({"message": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["reply"] ?? "Tidak ada balasan.";
      } else {
        return "Gagal mendapatkan balasan: ${response.statusCode}";
      }
    } catch (e) {
      throw Exception("Gemini tidak merespon: $e");
    }
  }
}
