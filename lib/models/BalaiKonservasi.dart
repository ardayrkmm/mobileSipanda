class BalaiKonservasi {
  String? idBalaiKonservasi;
  final String namaBalai;
  final String deskripsi;
  final String provinsi;
  final String gambarBalai;
  final String alamat;

  BalaiKonservasi({
    this.idBalaiKonservasi,
    required this.namaBalai,
    required this.deskripsi,
    required this.provinsi,
    required this.gambarBalai,
    required this.alamat,
  });
  factory BalaiKonservasi.fromJson(Map<String, dynamic> json) {
    return BalaiKonservasi(
      idBalaiKonservasi: json['id_balaikonservasi'],
      namaBalai: json['nama_balai'],
      deskripsi: json['deskripsi'],
      provinsi: json['provinsi'],
      gambarBalai: json['gambarbalai'],
      alamat: json['alamat'],
    );
  }

  // Method to convert BalaiKonservasi object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_balaikonservasi': idBalaiKonservasi,
      'nama_balai': namaBalai,
      'deskripsi': deskripsi,
      'provinsi': provinsi,
      'gambarbalai': gambarBalai,
      'alamat': alamat,
    };
  }
}
