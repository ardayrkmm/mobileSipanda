import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/LaporModel.dart';
import 'package:http/http.dart' as http;

class Laporanp extends ChangeNotifier {
  Future<String> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Periksa apakah layanan lokasi aktif
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Layanan lokasi tidak diaktifkan");
      }

      // Periksa izin akses lokasi
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Izin lokasi ditolak");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Izin lokasi ditolak secara permanen");
      }

      // Dapatkan lokasi pengguna
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return "${position.latitude},${position.longitude}";
    } catch (e) {
      throw Exception("Gagal mendapatkan lokasi: $e");
    }
  }

  Future<Map<String, dynamic>> buatLaporan(LaporModel lapor) async {
    final url = Uri.parse('${Config.urlBase}/api/lapor');

    try {
      // Ambil lokasi pengguna
      final lokasi = await _getCurrentLocation();

      // Isi field maps dengan lokasi pengguna
      lapor = LaporModel(
          id: lapor.id,
          namaLapor: lapor.namaLapor,
          nomerHp: lapor.nomerHp,
          alamat: lapor.alamat,
          maps: lokasi,
          keterangan: lapor.keterangan,
          status: lapor.status,
          gambar: lapor.gambar);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(lapor.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        notifyListeners();
        return {
          'success': true,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['error'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal membuat laporan: $e',
      };
    }
  }
}
