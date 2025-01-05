class UserModel {
  final String email;
  int? id;
  String? imgProfil;
  final String nama;
  final String noTelp;
  final String password;

  UserModel({
    required this.email,
    this.id,
    this.imgProfil,
    required this.nama,
    required this.noTelp,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
      imgProfil: json['img_profil'] ?? 'a',
      nama: json['nama'] ?? '',
      noTelp: json['no_telp'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'img_profil': imgProfil,
      'nama': nama,
      'no_telp': noTelp,
      'password': password,
    };
  }
}
