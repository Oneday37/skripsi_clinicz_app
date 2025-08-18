import 'package:http/http.dart' as http;

class SettingService {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/assets";

  // METHOD TO GET ABOUT US
  Future getAboutUsContent() async {
    final response = await http.get(Uri.parse("$baseUrl/about.html"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to load about us content");
    }
  }
}
