import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:http/http.dart' as http;

class scanProvider extends ChangeNotifier {
  bool _cekloading = false;
  String? _hasil;

  bool get loading => _cekloading;
  String? get hasil => _hasil;

  Future<Map<String, dynamic>> tambahGambar(File file) async {
    final url = Uri.parse('${Config.urlBase}/api/scan');

    try {
      final req = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await http.Response.fromStream(await req.send());

      if (response.statusCode == 200) {
        final Map<String, dynamic> responData = jsonDecode(response.body);
        print("Parsed Response: $responData");
        notifyListeners();
        return {
          'status': "success",
          'predicted_label': responData['predicted_label'],
          'image_path': responData['image_path'],
          'species_info': responData['species_info'],
        };
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return {'status': 'error', 'message': errorData['message']};
      }
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }
}
