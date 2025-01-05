import 'dart:convert';

import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:http/http.dart' as http;
import 'package:mobilecapstone/models/Kategori.dart';

class HewanService {
  Future<List<hewanModel>> ambilDataHewan(String pencarian) async {
    final respons = await http.get(
        Uri.parse('${Config.urlBase}/admin/api/hewan/kategori/$pencarian'));

    if (respons.statusCode == 200) {
      final List<dynamic> data = jsonDecode(respons.body)['body'];
      return data.map((json) => hewanModel.fromJson(json)).toList();
    } else {
      throw Exception('gagal Ambil data data');
    }
  }

  Future<List<KategoriM>> ambilDataKategori() async {
    final respn =
        await http.get(Uri.parse('${Config.urlBase}/admin/api/kategori'));
    if (respn.statusCode == 200) {
      final List<dynamic> dt = jsonDecode(respn.body)['body'];
      return dt.map((json) => KategoriM.fromJson(json)).toList();
    } else {
      throw Exception('gagal Ambil data data');
    }
  }
}
