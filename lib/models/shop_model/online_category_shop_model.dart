class OnlineShopByCategoryModel {
  String namaObat;
  String gambarObat;
  String deskripsiObat;

  OnlineShopByCategoryModel({
    required this.namaObat,
    required this.gambarObat,
    required this.deskripsiObat,
  });

  factory OnlineShopByCategoryModel.fromJson(Map<String, dynamic> json) {
    return OnlineShopByCategoryModel(
      namaObat: json["nama"] ?? "Nama obat tidak teridentifikasi",
      gambarObat:
          json["gambar"] ??
          "https://kec-sipispis.serdangbedagaikab.go.id/administrator/assets/img/img_pelayanan/belumada2.jpg",
      deskripsiObat: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
    );
  }
}
