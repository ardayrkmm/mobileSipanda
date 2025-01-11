import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/services/SessionService.dart';
import 'package:http/http.dart' as http;

class authP extends ChangeNotifier {
  UserModel? _currentUser;
  String? _token;
  bool _isLoading = false;
  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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
          _token = datas['token'];
          await session.saveToken(_token!);
        }

        if (datas.containsKey('user')) {
          final userData = datas['user'] as Map<String, dynamic>;
          _currentUser = UserModel.fromJson(userData);
          await session.saveUser(_currentUser!);
        }
        _setLoading(false);
        notifyListeners();
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
        _token = data['token'];
        _currentUser = UserModel(
          id: data['user']['id'],
          email: data['user']['email'],
          nama: data['user']['nama'],
          noTelp: data['user']['no_telp'].toString(),
          imgProfil: data['user']['img_profil'],
          password: '',
        );

        await session.saveToken(_token!);
        await session.saveUser(_currentUser!);
        _setLoading(false);
        notifyListeners();
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
        notifyListeners();
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
        notifyListeners();
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
      String noTelepon, File? imgProfil) async {
    final url = Uri.parse('${Config.urlBase}/api/profil/update');

    try {
      var request = http.MultipartRequest('POST', url);

      // Tambahkan data form
      if (id != null) {
        request.fields['id'] = id.toString();
      }
      request.fields['nama'] = nama;
      request.fields['email'] = email;
      request.fields['no_telp'] = noTelepon;

      if (imgProfil != null) {
        request.files.add(
          await http.MultipartFile.fromPath('img_profil', imgProfil.path),
        );
      }

      // Kirim permintaan multipart
      var response = await request.send();

      // Periksa hasil respons
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);

        // Update currentUser (jika perlu)
        _currentUser = UserModel.fromJson(data['user']);
        await session.saveUser(_currentUser!);
        notifyListeners(); // Untuk memberitahu listener agar re-render data

        return {
          'status': 'success',
          'message': 'Profil berhasil diperbarui!',
          'user': _currentUser,
        };
      } else {
        final errorResponse = await response.stream.bytesToString();
        return {
          'status': 'error',
          'message': 'Failed to update profile: $errorResponse',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Error updating profile: $e',
      };
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    await SessionService().clearSession();
    notifyListeners(); // Notifikasi untuk perubahan data
  }
}
