class AuthenthicationModel {
  final String idPengguna;
  final String usernamePengguna;
  final String emailPengguna;
  final DateTime dateOfBirthPengguna;
  final String genderPengguna;
  final String profileImagePengguna;

  AuthenthicationModel({
    required this.idPengguna,
    required this.usernamePengguna,
    required this.emailPengguna,
    required this.dateOfBirthPengguna,
    required this.genderPengguna,
    required this.profileImagePengguna,
  });

  factory AuthenthicationModel.fromJson(Map<String, dynamic> json) {
    return AuthenthicationModel(
      idPengguna: json['_id'] ?? "-",
      usernamePengguna: json['username'] ?? "-",
      emailPengguna: json['email'] ?? "-",
      dateOfBirthPengguna: DateTime.parse(json['dateOfBirth']),
      genderPengguna:
          json['gender'].toString()[0].toUpperCase() +
          json['gender'].toString().substring(1),
      profileImagePengguna:
          json['profileImage'] ??
          "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg",
    );
  }
}
