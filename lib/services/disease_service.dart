import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:skripsi_clinicz_app/models/disease_model/general_disease_model.dart';
import 'package:skripsi_clinicz_app/models/disease_model/specific_disease_model.dart';

class DiseaseService {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/disease";

  // METHOD TO GET ALL DISEASE
  Future<List<GeneralDiseaseModel>> getAllDisease() async {
    final response = await http.get(Uri.parse(baseUrl));

    try {
      if (response.statusCode == 200) {
        final List responseBody = jsonDecode(response.body);
        final result =
            responseBody.map((e) => GeneralDiseaseModel.fromJson(e)).toList();
        return result;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Catch Error: $e");
    }
  }

  // METHOD TO GET DISEASE BY CATEGORY
  Future<List<GeneralDiseaseModel>> getDiseaseByCategroy(
    String diseaseCategory,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/kategori/$diseaseCategory"),
    );

    try {
      if (response.statusCode == 200) {
        final List responseBody = jsonDecode(response.body);
        final result =
            responseBody.map((e) => GeneralDiseaseModel.fromJson(e)).toList();
        return result;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Catch Error: $e");
    }
  }

  // METHOD TO GET DISEASE DETAIL
  Future<SpecificDiseaseModel> getSingleDiseaseDetail(
    String diseaseName,
  ) async {
    final response = await http.get(Uri.parse("$baseUrl/$diseaseName"));
    try {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return SpecificDiseaseModel.fromJson(responseBody);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Catch Error: $e");
    }
  }
}
