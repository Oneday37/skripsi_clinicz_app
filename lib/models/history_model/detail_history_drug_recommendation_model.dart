class DetailHistoryDrugRecommendationModel {
  String id;
  String userId;
  String type;
  Input input;
  List<Output> output;
  DateTime createdAt;
  int v;

  DetailHistoryDrugRecommendationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.input,
    required this.output,
    required this.createdAt,
    required this.v,
  });

  factory DetailHistoryDrugRecommendationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DetailHistoryDrugRecommendationModel(
      id: json["_id"],
      userId: json["userId"],
      type: json["type"],
      input: Input.fromJson(json["input"]),
      output: List<Output>.from(json["output"].map((x) => Output.fromJson(x))),
      createdAt: DateTime.parse(json["createdAt"]),
      v: json["__v"],
    );
  }
}

class Input {
  String penyakit;

  Input({required this.penyakit});

  factory Input.fromJson(Map<String, dynamic> json) =>
      Input(penyakit: json["penyakit"]);
}

class Output {
  String namaObat;
  String deskripsiObat;
  String kandunganObat;
  String dosisObat;
  String aturanPakaiObat;
  String efekSampingObat;
  List<LinkStore> tokoOnline1;
  List<LinkStore> tokoOnline2;
  double? similarityObat;
  String pesan;

  Output({
    required this.namaObat,
    required this.deskripsiObat,
    required this.kandunganObat,
    required this.dosisObat,
    required this.aturanPakaiObat,
    required this.efekSampingObat,
    required this.tokoOnline1,
    required this.tokoOnline2,
    required this.similarityObat,
    required this.pesan,
  });

  factory Output.fromJson(Map<String, dynamic> json) {
    return Output(
      namaObat: json["obat"] ?? "Tidak ada nama obat untuk penyakit ini",
      deskripsiObat: json["deskripsi"] ?? "Deskripsi obat tidak tersedia",
      kandunganObat: json["kandungan"] ?? "-",
      dosisObat: json["dosis"] ?? "-",
      aturanPakaiObat: json["aturanPakai"] ?? "-",
      efekSampingObat: json["efekSamping"] ?? "-",
      tokoOnline1:
          (json["tokoOnline1"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      tokoOnline2:
          (json["tokoOnline2"] ?? [])
              .map<LinkStore>((x) => LinkStore.fromJson(x))
              .toList(),
      similarityObat: json["similarity"]?.toDouble(),
      pesan: json["pesan"] ?? "",
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
