class OnlineShopModel {
  String namaObat;
  String gambarObat;
  String deskripsiObat;

  OnlineShopModel({
    required this.namaObat,
    required this.gambarObat,
    required this.deskripsiObat,
  });

  factory OnlineShopModel.fromJson(Map<String, dynamic> json) {
    return OnlineShopModel(
      namaObat: json["nama"] ?? "Nama obat tidak teridentifikasi",
      gambarObat:
          json["gambar"] ??
          "https://kec-sipispis.serdangbedagaikab.go.id/administrator/assets/img/img_pelayanan/belumada2.jpg",
      deskripsiObat: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
    );
  }
}
