class KategoriM {
  String id_kategori;
  String nama_kategori;

  KategoriM({required this.id_kategori, required this.nama_kategori});

  factory KategoriM.fromJson(Map<String, dynamic> json) {
    return KategoriM(
        id_kategori: json['id_kategori'], nama_kategori: json['nama_kategori']);
  }

  Map<String, dynamic> toJson() {
    return {'id_kategori': id_kategori, 'nama_kategori': nama_kategori};
  }
}
