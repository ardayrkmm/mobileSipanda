import 'dart:convert';
import 'dart:io';

import 'package:mobilecapstone/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:mobilecapstone/services/SessionService.dart';
import 'package:mobilecapstone/config.dart';

class Auths {
  final session = SessionService();
  Future<Map<String, dynamic>> buatAkun(UserModel user) async {
    final url = Uri.parse('${Config.urlBase}/api/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': user.email,
          'nama': user.nama,
          'no_telp': user.noTelp,
          'password': user.password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        final datas = jsonDecode(response.body) as Map<String, dynamic>;
        if (datas.containsKey('token')) {
          await session.saveToken(datas['token']);
        }

        if (datas.containsKey('user')) {
          final userData = datas['user'] as Map<String, dynamic>;
          final simpanDataUser = UserModel.fromJson(userData);
          await session.saveUser(simpanDataUser);
        }
        return {
          'success': true,
          'message': datas['message'] ?? 'Akun berhasil dibuat!',
          'token': datas['token'],
          'user': datas['user']
        };
      } else {
        return {
          'message': 'Unexpected status code: ${response.statusCode}',
          'status': 'danger'
        };
      }
    } catch (error) {
      return {'message': 'Error: $error', 'status': 'danger'};
    }
  }

  Future<Map<String, dynamic>> login(String Email, String pass) async {
    final url = Uri.parse('${Config.urlBase}/api/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': Email,
          'password': pass,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = UserModel(
          id: data['user']['id'],
          email: data['user']['email'],
          nama: data['user']['nama'],
          noTelp: data['user']['no_telp'].toString(),
          imgProfil: data['user']['img_profil'],
          password: '',
        );

        await session.saveToken(token);
        await session.saveUser(user);
        return {'success': true, 'token': data['token'], 'user': data['user']};
      } else {
        return {
          'message': 'Unexpected status code: ${response.statusCode}',
          'status': 'danger'
        };
      }
    } catch (error) {
      return {'message': 'Error: $error', 'status': 'bahaya'};
    }
  }

  Future<Map<String, dynamic>> mintaToken(String email) async {
    final url = Uri.parse('${Config.urlBase}/api/token/resetpassword');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"email": email}));

      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": jsonDecode(response.body)["message"]
        };
      } else {
        final error = jsonDecode(response.body)["error"];
        return {"success": false, "message": error ?? "Terjadi kesalahan."};
      }
    } catch (e) {
      return {"success": false, "message": "Tidak dapat terhubung ke server."};
    }
  }

  Future<Map<String, dynamic>> resetPassword(String email, String token,
      String password, String ConfirmPassword) async {
    final url = Uri.parse('${Config.urlBase}/api/resetpassword');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "email": email,
            "token": token,
            "password": password,
            "confirm_password": ConfirmPassword
          }));

      if (response.statusCode == 200) {
        return {
          "success": true,
          "message": jsonDecode(response.body)["message"]
        };
      } else {
        final error = jsonDecode(response.body)["error"];
        return {"success": false, "message": error ?? "Terjadi kesalahan."};
      }
    } catch (e) {
      return {"success": false, "message": "Tidak dapat terhubung ke server."};
    }
  }

  Future<Map<String, dynamic>> updateProfil(int? id, String nama, String email,
      String noTelepon, String? imgProfil) async {
    final url = Uri.parse('${Config.urlBase}/api/profil/update');

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'id': id,
            'email': email,
            'nama': nama,
            'no_telp': noTelepon,
            'img_profil': imgProfil
          }));
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika berhasil, ambil data dari body response
        final data = jsonDecode(response.body);

        // Mengembalikan response yang sukses (bisa berisi data user atau status)
        return {
          'status': 'success',
          'message': 'Profil berhasil diperbarui!',
          'data': data, // Bisa berisi informasi user terbaru
        };
      } else {
        // Jika status code bukan 200, lemparkan exception dengan body response
        return {
          'status': 'error',
          'message': 'Failed to update profile: ${response.body}',
        };
      }
    } catch (e) {
      // Tangani error jika terjadi kesalahan pada saat request
      return {
        'status': 'error',
        'message': 'Error updating profile: $e',
      };
    }
  }
}
