import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_clinicz_app/models/history_model/detail_disease_prediction_history_model.dart';
import 'package:skripsi_clinicz_app/models/history_model/detail_drug_recommendation_history_model.dart';
import 'package:skripsi_clinicz_app/models/history_model/history_model.dart';

class HistoryServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/bot";

  // METHOD DISEASE HISTORY
  Future<List<HistoryModel>> getHistoryPrediction() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token tidak ditemukan. Harap login kembali.");
      }

      final response = await http.get(
        Uri.parse("$baseUrl/riwayat-penyakit"),
        headers: {'Cookie': 'auth_token=$token'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['data'];
        if (data == null || data is! List) {
          return [];
        }

        final historyResult =
            data.map<HistoryModel>((e) => HistoryModel.fromJson(e)).toList();

        return historyResult;
      } else {
        throw Exception("Gagal mengambil data. Kode: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(
        "Catch Error-Terjadi kesalahan saat mengambil riwayat: $e",
      );
    }
  }

  // METHOD DRUG HISTORY
  Future<List<HistoryModel>> getPredictionResult() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {}
    final response = await http.get(
      Uri.parse("$baseUrl/riwayat-obat"),
      headers: {'Cookie': 'auth_token=$token'},
    );

    try {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List historyResponse = responseBody['data'];
        final historyResult =
            historyResponse.map((e) => HistoryModel.fromJson(e)).toList();
        return historyResult;
      } else {
        throw Exception("Failed to get data");
      }
    } catch (e) {
      throw Exception("Catch Error: $e");
    }
  }

  // METHOD DISEASE PREDICTION HISTORY
  Future<DetailDiseasePrediction> getDetailDiseasePredictionHistory(
    String id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("$baseUrl/riwayat/$id"),
      headers: {'Cookie': 'auth_token=$token'},
    );

    try {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['data'];

        if (data == null) {
          throw Exception("Data tidak ditemukan dalam response");
        }

        return DetailDiseasePrediction.fromJson(data);
      } else {
        throw Exception("Gagal memuat data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Catch Error: $e");
    }
  }

  // METHOD DRUG RECOMMENDATION HISTORY
  Future<DetailDrugRecommendationModel> getDetailDrugRecommendationHistory(
    String id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("$baseUrl/riwayat/$id"),
      headers: {'Cookie': 'auth_token=$token'},
    );

    try {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final data = responseBody['data'];

        if (data == null) {
          throw Exception("Data tidak ditemukan dalam response");
        }

        return DetailDrugRecommendationModel.fromJson(data);
      } else {
        throw Exception("Gagal memuat data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Catch Error: $e");
    }
  }
}
