import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mockito/mockito.dart';

import 'Auth.mocks.mocks.dart';

void main() {
  late MockauthP authsM;

  setUp(() {
    authsM = MockauthP();
  });
  group("testing fungsi dari register", () {
    test(
        "testing ketika user melakukan register dengan input email, notelp,password,nama",
        () async {
      String email = "ardyrkm11@gmail.com";
      String nama = "ardayudrikm";
      String password = "ardagantengbgt";
      String notelp = "0821371271";

      UserModel user = UserModel(
          email: email, nama: nama, noTelp: notelp, password: password);
      when(authsM.buatAkun(user)).thenAnswer((s) async => {
            "success": true,
            'user': {
              "nama": nama,
              'email': email,
              'noTelp': notelp,
            }
          });
      final hasil = await authsM.buatAkun(user);

      expect(hasil['success'], true);
    });

    test("testing ketika user melakukan register email salah", () async {
      String email = "ardyrkm11";
      String nama = "ardayudrikm";
      String password = "ardagantengbgt";
      String notelp = "0821371271";

      UserModel user = UserModel(
          email: email, nama: nama, noTelp: notelp, password: password);
      when(authsM.buatAkun(user)).thenAnswer((s) async => {
            "success": false,
            'user': {
              "nama": nama,
              'email': email,
              'noTelp': notelp,
            }
          });
      final hasil = await authsM.buatAkun(user);

      expect(hasil['success'], false);
    });

    test("testing ketika user melakukan register dengan inputan kosong",
        () async {
      String email = "";
      String nama = "";
      String password = "";
      String notelp = "";

      UserModel user = UserModel(
          email: email, nama: nama, noTelp: notelp, password: password);
      when(authsM.buatAkun(user)).thenAnswer((s) async => {
            "success": false,
            'user': {
              "nama": nama,
              'email': email,
              'noTelp': notelp,
            }
          });
      final hasil = await authsM.buatAkun(user);

      expect(hasil['success'], false);
    });
  });
}
