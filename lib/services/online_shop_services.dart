import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skripsi_clinicz_app/models/shop_model/online_all_shop_model.dart';
import 'package:skripsi_clinicz_app/models/shop_model/online_category_shop_model.dart';
import 'package:skripsi_clinicz_app/models/shop_model/online_single_shop_model.dart';

class OnlineShopServices {
  final String baseUrl =
      "https://unfortunate-odessa-tsukasa-org-926b4973.koyeb.app/shop/obat";

  // METHOD GET ALL DRUGS
  Future<List<OnlineShopModel>> getAllDrugsShop() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final result =
          responseBody.map((e) => OnlineShopModel.fromJson(e)).toList();
      return result;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // METHOD GET SINGLE DRUG
  Future<OnlineSingleDrugModel> getSingleDrusShop(String drugName) async {
    final response = await http.get(Uri.parse("$baseUrl/$drugName"));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return OnlineSingleDrugModel.fromJson(responseBody);
    } else {
      throw Exception("Failed to load data");
    }
  }

  // METHOD GET DRUGS BY CATEGORY
  Future<List<OnlineShopByCategoryModel>> getDrugsByCategoryShop(
    String diseaseCategory,
  ) async {
    final response = await http.get(
      Uri.parse("$baseUrl/kategori/$diseaseCategory"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final result =
          responseBody
              .map((e) => OnlineShopByCategoryModel.fromJson(e))
              .toList();
      return result;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // METHOD GET DRUG IMAGE
  Future<String?> getGambarByNama(String diseaseName) async {
    List<OnlineShopModel> daftarObat = await getAllDrugsShop();

    try {
      OnlineShopModel drugImage = daftarObat.firstWhere(
        (obat) => obat.namaObat == diseaseName,
      );
      return drugImage.gambarObat;
    } catch (e) {
      return null;
    }
  }
}
