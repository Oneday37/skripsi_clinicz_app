class OnlineShopModel {
  String nama;
  String gambar;
  String deskripsi;

  OnlineShopModel({
    required this.nama,
    required this.gambar,
    required this.deskripsi,
  });

  factory OnlineShopModel.fromJson(Map<String, dynamic> json) {
    return OnlineShopModel(
      nama: json["nama"] ?? "Nama obat tidak teridentifikasi",
      gambar:
          json["gambar"] ??
          "https://global.tamu.edu/getmedia/f8ee83c6-cb20-4df8-8221-dd8f9c995995/no_image.png?width=250&height=250&ext=.png",
      deskripsi: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
    );
  }
}
