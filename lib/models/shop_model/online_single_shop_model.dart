class OnlineSingleDrugModel {
  String nama;
  String deskripsi;
  String kandungan;
  String dosis;
  String aturanPakai;
  String efekSamping;
  List linkStoreSatu;
  List linkStoreDua;
  String sumber;
  String gambar;

  OnlineSingleDrugModel({
    required this.nama,
    required this.deskripsi,
    required this.kandungan,
    required this.dosis,
    required this.aturanPakai,
    required this.efekSamping,
    required this.linkStoreSatu,
    required this.linkStoreDua,
    required this.sumber,
    required this.gambar,
  });

  factory OnlineSingleDrugModel.fromJson(Map<String, dynamic> json) {
    return OnlineSingleDrugModel(
      nama: json["nama"] ?? "Nama obat tidak teridentifikasi",
      deskripsi: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
      kandungan: json["kandungan"] ?? "-",
      dosis: json["dosis"] ?? "-",
      aturanPakai: json["aturanPakai"] ?? "-",
      efekSamping: json["efekSamping"] ?? "-",
      linkStoreSatu:
          (json["linkStoreSatu"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      linkStoreDua:
          (json["linkStoreDua"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      sumber: json["sumber"] ?? "-",
      gambar:
          json["gambar"] ??
          "https://global.tamu.edu/getmedia/f8ee83c6-cb20-4df8-8221-dd8f9c995995/no_image.png?width=250&height=250&ext=.png",
    );
  }
}

class LinkStore {
  String toko;
  String url;

  LinkStore({required this.toko, required this.url});

  factory LinkStore.fromJson(Map<String, dynamic> json) {
    return LinkStore(toko: json["Toko"], url: json["Link"]);
  }
}
