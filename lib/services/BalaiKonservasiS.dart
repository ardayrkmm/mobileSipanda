import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/BalaiKonservasi.dart';

class Balaikonservasis {
  Future<List<BalaiKonservasi>> ambilDataBalai() async {
    final respn = await http
        .get(Uri.parse('${Config.urlBase}/admin/api/balaikonservasi'));
    if (respn.statusCode == 200) {
      final List<dynamic> dt = jsonDecode(respn.body)['body'];
      return dt.map((json) => BalaiKonservasi.fromJson(json)).toList();
    } else {
      throw Exception('gagal Ambil data data');
    }
  }
}
