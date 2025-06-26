import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skripsi_clinicz_app/models/nearby_faskes_model.dart';

class NearbyFaskesServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/location";

  Future<List<NearbyClinicsModel>> getNearbyClinics({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"lat": latitude, "lng": longitude}),
      );

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        final List clinics = jsonBody['clinics'];

        return clinics
            .map((clinic) => NearbyClinicsModel.fromJson(clinic))
            .toList();
      } else {
        throw Exception("Gagal mengambil data faskes");
      }
    } catch (e) {
      throw Exception("Error saat mengambil data faskes: $e");
    }
  }
}
