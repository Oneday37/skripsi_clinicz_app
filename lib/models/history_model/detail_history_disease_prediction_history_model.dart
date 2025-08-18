class DetailHistoryDiseasePrediction {
  final String id;
  final String userId;
  final String type;
  final InputData input;
  final OutputData output;
  final DateTime createdAt;

  DetailHistoryDiseasePrediction({
    required this.id,
    required this.userId,
    required this.type,
    required this.input,
    required this.output,
    required this.createdAt,
  });

  factory DetailHistoryDiseasePrediction.fromJson(Map<String, dynamic> json) {
    return DetailHistoryDiseasePrediction(
      id: json['_id'] ?? "-",
      userId: json['userId'] ?? "-",
      type: json['type'] ?? "-",
      input: InputData.fromJson(json['input']),
      output: OutputData.fromJson(json['output']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class InputData {
  final String text;

  InputData({required this.text});

  factory InputData.fromJson(Map<String, dynamic> json) {
    return InputData(text: json['text']);
  }
}

class OutputData {
  final List<Disease> penyakit;
  final String deskripsiPenyakit;
  final String pengobatanPenyakit;
  final String sumberInformasi;

  OutputData({
    required this.penyakit,
    required this.deskripsiPenyakit,
    required this.pengobatanPenyakit,
    required this.sumberInformasi,
  });

  factory OutputData.fromJson(Map<String, dynamic> json) {
    return OutputData(
      penyakit:
          (json['penyakit'] as List<dynamic>)
              .map((e) => Disease.fromJson(e))
              .toList(),
      deskripsiPenyakit: json['deskripsi'] ?? "-",
      pengobatanPenyakit: json['pengobatan'] ?? "-",
      sumberInformasi: json['sumber'] ?? "-",
    );
  }
}

class Disease {
  final String penyakit;
  final String deskripsiPenyakit;
  final String pengobatanPenyakit;
  final String sumberInformasi;

  Disease({
    required this.penyakit,
    required this.deskripsiPenyakit,
    required this.pengobatanPenyakit,
    required this.sumberInformasi,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      penyakit: json['penyakit'] ?? '-',
      deskripsiPenyakit: json['deskripsi'] ?? '-',
      pengobatanPenyakit: json['pengobatan'] ?? '-',
      sumberInformasi: json['sumber'] ?? '-',
    );
  }
}
