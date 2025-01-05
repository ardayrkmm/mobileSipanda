import 'package:mobilecapstone/models/Kategori.dart';
import 'package:mobilecapstone/models/ciri_ciri.dart';

class hewanModel {
  String id;
  String nama;
  String namaLatin;
  String status;
  int populasi;
  String deskripsi;
  String habitat;
  String urlGambar;
  KategoriM kategori;
  List<CiriCiriModel>? ciriCiri; // List diperbaiki agar sesuai

  hewanModel({
    required this.id,
    required this.nama,
    required this.namaLatin,
    required this.status,
    required this.populasi,
    required this.deskripsi,
    required this.habitat,
    required this.urlGambar,
    required this.kategori,
    this.ciriCiri,
  });

  /// Factory method untuk decoding JSON
  factory hewanModel.fromJson(Map<String, dynamic> json) {
    return hewanModel(
      id: json['id'],
      nama: json['nama'],
      namaLatin: json['nama_latin'],
      status: json['status'],
      populasi: json['populasi'],
      deskripsi: json['deskripsi'],
      habitat: json['habitat'],
      urlGambar: json['url_gambar'],
      kategori: KategoriM.fromJson(json['kategori']),
      ciriCiri: json['ciri_ciri'] != null
          ? (json['ciri_ciri'] as List<dynamic>)
              .map((ciri) => CiriCiriModel.fromJson(ciri))
              .toList()
          : [], // Default: List kosong jika null
    );
  }

  /// Method untuk encoding ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nama_latin': namaLatin,
      'status': status,
      'populasi': populasi,
      'deskripsi': deskripsi,
      'habitat': habitat,
      'url_gambar': urlGambar,
      'kategori': kategori.toJson(),
      'ciri_ciri':
          ciriCiri?.map((e) => e.toJson()).toList(), // Null-safe mapping
    };
  }
}
