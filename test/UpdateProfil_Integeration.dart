import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobilecapstone/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/UpdateProfil.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'Auth.mocks.mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockauthP authsM;

  setUp(() {
    authsM = MockauthP();
    HttpOverrides.global = null;
  });
  testWidgets("User menggunakan fitur update profil",
      (WidgetTester tester) async {
    // Data dummy untuk user
    final user = UserModel(
        id: 1,
        nama: "Arda Update",
        email: "ardyrkm23@gmail.com",
        noTelp: "08123456789",
        imgProfil: null,
        password: "");

    // Mock auth provider

    // Mock behavior untuk fungsi updateProfil
    when(authsM.updateProfil(
      user.id,
      "Arda Update Sukses",
      "ardyrkm23@gmail.com",
      "08123456789",
      null,
    )).thenAnswer((_) async => {
          "status": "success",
          "message": "Profil berhasil diperbarui!",
        });

    // Render widget UpdateProfil
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<authP>.value(
          value: authsM,
          child: Updateprofil(usr: user),
        ),
      ),
    );

    // Temukan widget input dan tombol
    final namaField = find.byKey(Key("inputNama"));
    final emailField = find.byKey(Key("inputEmail"));
    final telpField = find.byKey(Key("inputTelepon"));
    final simpanButton = find.byKey(Key("tombolSimpan"));

    // Pastikan semua widget ditemukan
    expect(namaField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(telpField, findsOneWidget);
    expect(simpanButton, findsOneWidget);

    // Isi input fields dengan data baru
    await tester.enterText(namaField, "Arda Update Sukses");
    await tester.enterText(emailField, "ardyrkm23@gmail.com");
    await tester.enterText(telpField, "08123456789");

    // Simulasi tap tombol simpan
    await tester.tap(simpanButton);
    await tester.pumpAndSettle();

    // Verifikasi bahwa fungsi updateProfil dipanggil dengan argumen yang benar
    verify(authsM.updateProfil(
      user.id,
      "Arda Update Sukses",
      "ardyrkm23@gmail.com",
      "08123456789",
      null,
    )).called(1);

    // Pastikan kembali ke halaman utama setelah update
    expect(find.byKey(Key("halamanMainpage")), findsOneWidget);
  });
}
