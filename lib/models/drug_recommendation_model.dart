class DrugRecommendationModel {
  late String namaObat;
  late String deskripsi;
  late String kandungan;
  late String dosis;
  late String aturanPakai;
  late String efekSamping;
  List linkStoretokoOnline1;
  List linkStoretokoOnline2;
  String pesan;

  DrugRecommendationModel({
    required this.namaObat,
    required this.deskripsi,
    required this.kandungan,
    required this.dosis,
    required this.aturanPakai,
    required this.efekSamping,
    required this.linkStoretokoOnline1,
    required this.linkStoretokoOnline2,
    required this.pesan,
  });

  factory DrugRecommendationModel.fromJson(Map<String, dynamic> json) {
    return DrugRecommendationModel(
      namaObat: json["obat"] ?? "Tidak ada nama obat untuk penyakit ini",
      deskripsi: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
      kandungan: json["kandungan"] ?? "-",
      dosis: json["dosis"] ?? "-",
      aturanPakai: json["aturanPakai"] ?? "-",
      efekSamping: json["efekSamping"] ?? "-",
      linkStoretokoOnline1:
          (json["tokoOnline1"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      linkStoretokoOnline2:
          (json["tokoOnline2"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      pesan: json["pesan"] ?? "",
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
