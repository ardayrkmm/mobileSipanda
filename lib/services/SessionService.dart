import 'package:mobilecapstone/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Menyimpan token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  // Mengambil token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Menghapus token
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  // Menyimpan data pengguna
  Future<void> saveUser(UserModel usr) async {
    final pr = await SharedPreferences.getInstance();
    await pr.setInt('id', usr.id!);
    await pr.setString('nama', usr.nama.toString());
    await pr.setString('email', usr.email.toString());
    await pr.setString('img_profil', usr.imgProfil.toString());
    await pr.setString('no_telp', usr.noTelp);
  }

  // Mengambil data pengguna
  Future<UserModel> getUser() async {
    final pr = await SharedPreferences.getInstance();
    int? ids = pr.getInt('id');
    String? namas = pr.getString('nama');
    String? emails = pr.getString('email');
    String? imgProfil = pr.getString('img_profil');
    String? no_telp = pr.getString('no_telp');

    return UserModel(
      id: ids,
      email: emails!,
      nama: namas!,
      noTelp: no_telp!,
      imgProfil: imgProfil,
      password: '',
    );
  }

  // Menghapus data pengguna
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('nama');
    await prefs.remove('email');
    await prefs.remove('img_profil');
    await prefs.remove('no_telp');
  }

  // Menghapus semua data (token dan data pengguna)
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
