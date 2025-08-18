class OnlineSingleDrugModel {
  String namaObat;
  String deskripsiObat;
  String kandunganObat;
  String dosisObat;
  String aturanPakaiObat;
  String efekSampingObat;
  List linkStoreSatu;
  List linkStoreDua;
  String sumber;
  String gambarObat;

  OnlineSingleDrugModel({
    required this.namaObat,
    required this.deskripsiObat,
    required this.kandunganObat,
    required this.dosisObat,
    required this.aturanPakaiObat,
    required this.efekSampingObat,
    required this.linkStoreSatu,
    required this.linkStoreDua,
    required this.sumber,
    required this.gambarObat,
  });

  factory OnlineSingleDrugModel.fromJson(Map<String, dynamic> json) {
    return OnlineSingleDrugModel(
      namaObat: json["nama"] ?? "Nama obat tidak teridentifikasi",
      deskripsiObat: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
      kandunganObat: json["kandungan"] ?? "-",
      dosisObat: json["dosis"] ?? "-",
      aturanPakaiObat: json["aturanPakai"] ?? "-",
      efekSampingObat: json["efekSamping"] ?? "-",
      linkStoreSatu:
          (json["linkStoreSatu"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      linkStoreDua:
          (json["linkStoreDua"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      sumber: json["sumber"] ?? "-",
      gambarObat:
          json["gambar"] ??
          "https://kec-sipispis.serdangbedagaikab.go.id/administrator/assets/img/img_pelayanan/belumada2.jpg",
    );
  }
}

class LinkStore {
  String namaToko;
  String urlToko;

  LinkStore({required this.namaToko, required this.urlToko});

  factory LinkStore.fromJson(Map<String, dynamic> json) {
    return LinkStore(namaToko: json["Toko"], urlToko: json["Link"]);
  }
}
