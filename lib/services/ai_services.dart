import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_clinicz_app/models/drug_recommendation_model/detail_drug_recommendation_model.dart';
import 'package:skripsi_clinicz_app/models/prediction_model/detail_disease_prediction_model.dart';
import 'package:skripsi_clinicz_app/models/drug_recommendation_model/drug_recommendation_model.dart';
import 'package:skripsi_clinicz_app/models/prediction_model/disease_prediction_model.dart';

class AIServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/bot";

  // METHOD PREDICTION DISEASE
  Future<List<DiseasePredictionModel>?> getPrediction(
    String areaDisease,
    String symptomsMessage,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final response = await http.post(
      Uri.parse("$baseUrl/predict-penyakit"),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'auth_token=$token',
      },
      body: jsonEncode({"bagianTubuh": areaDisease, 'gejala': symptomsMessage}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List data = body['data'];
      return data.map((data) => DiseasePredictionModel.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load data prediction");
    }
  }

  // METHOD GET DETAIL PREDICT
  Future<DetailDiseasePredictionModel?> getDetailPrediction(
    String diseaseName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl/predict-penyakit-detail/$diseaseName"),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'auth_token=$token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final detailBody = responseBody['data'];
      return DetailDiseasePredictionModel.fromJson(detailBody);
    } else {
      throw Exception("Failed to load data prediction");
    }
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
        throw Exception("Catch Error: Parsing gagal");
      }
    } else {
      throw Exception("Gagal mengambil data dari server");
    }
  }

  // METHOD GET DETAIL DRUG RECOMMENDATION
  Future<DetailDrugRecommendationModel?> getDetailDrugRecommendations(
    String drugName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl/rekomendasi-obat/$drugName"),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'auth_token=$token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final detailBody = responseBody['data'];
      return DetailDrugRecommendationModel.fromJson(detailBody);
    } else {
      throw Exception("Failed to load data prediction");
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
      throw Exception("Catch Error Gemini tidak merespon: $e");
    }
  }
}
