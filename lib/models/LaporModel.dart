class LaporModel {
  final String id;
  final String namaLapor;
  final String nomerHp;
  final String alamat;
  final String maps;
  final String keterangan;
  final String status;

  LaporModel({
    required this.id,
    required this.namaLapor,
    required this.nomerHp,
    required this.alamat,
    required this.maps,
    required this.keterangan,
    required this.status,
  });

  // Konversi dari JSON ke Model
  factory LaporModel.fromJson(Map<String, dynamic> json) {
    return LaporModel(
      id: json['id'],
      namaLapor: json['nama_lapor'],
      nomerHp: json['nomer_hp'],
      alamat: json['alamat'],
      maps: json['maps'],
      keterangan: json['keterangan'],
      status: json['status'],
    );
  }

  // Konversi dari Model ke JSON
  Map<String, dynamic> toJson() {
    return {
      'nama_lapor': namaLapor,
      'nomer_hp': nomerHp,
      'alamat': alamat,
      'maps': maps,
      'keterangan': keterangan,
      'status': status,
    };
  }
}
