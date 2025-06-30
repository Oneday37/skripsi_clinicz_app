class OnlineShopByCategoryModel {
  String nama;
  String gambar;
  String deskripsi;

  OnlineShopByCategoryModel({
    required this.nama,
    required this.gambar,
    required this.deskripsi,
  });

  factory OnlineShopByCategoryModel.fromJson(Map<String, dynamic> json) {
    return OnlineShopByCategoryModel(
      nama: json["nama"] ?? "Nama obat tidak teridentifikasi",
      gambar:
          json["gambar"] ??
          "https://global.tamu.edu/getmedia/f8ee83c6-cb20-4df8-8221-dd8f9c995995/no_image.png?width=250&height=250&ext=.png",
      deskripsi: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
    );
  }
}
