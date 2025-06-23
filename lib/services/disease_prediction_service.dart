import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_clinicz_app/models/disease_prediction_model.dart';

class PredictionService {
  final String baseUrl =
      "https://global-rosanna-gunadarma-university-d9c92241.koyeb.app/bot";

  // METHOD GET DISEASE PREDICTION
  Future<PenyakitPrediction?> getPrediction(String message) async {
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
        return PenyakitPrediction.fromJson(data[0]);
      }
    } else {
      print("Status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }

    return null;
  }
}
