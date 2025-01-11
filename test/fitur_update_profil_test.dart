import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/LaporModel.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/pages/UpdateProfil.dart';
import 'package:mobilecapstone/providers/LaporanP.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_overrides.dart';

import 'package:flutter_test/flutter_test.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MyHttpOverrides();
    SharedPreferences.setMockInitialValues({});
  });

  group("testing unit", () {
    test('ketika user sukses testing', () async {
      final authProvider = authP();

      final result = await authProvider.updateProfil(
        9,
        'Fajar wicaksono',
        'fajarajah322@gmail.com',
        '089665753965',
        null,
      );

      print('Hasil respons: $result'); // Debug respons server
      expect(result['status'], 'success');
      expect(result['message'], 'Profil berhasil diperbarui!');
    });

    test('ketika gagal dalam melakukan update profile', () async {
      final authProvider = authP();

      // Simulasikan data yang salah untuk memastikan hasil error
      final result = await authProvider.updateProfil(
        null,
        'Fajar wicaksono',
        'fajarajah322@gmail.com',
        '089665753965',
        null,
      );

      expect(result['status'], 'error');
      expect(result['message'],
          'Failed to update profile: {"msg":"Invalid or missing user ID"}\n');
    });
  });

  group("Widget Testing", () {
    final user = UserModel(
        id: 11,
        nama: 'saipul',
        email: 'saipul22@gmail.com',
        noTelp: '123456789',
        imgProfil: "",
        password: "");

    testWidgets('Inputan dalam halaman updateProfil',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => authP())],
          child: MaterialApp(
            home: Updateprofil(usr: user),
          ),
        ),
      );

      // Tunggu hingga widget selesai dirender sepenuhnya
      await tester.pumpAndSettle();

      expect(find.text('Update Profil'), findsOneWidget);
      expect(find.text('Nama'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Telepon'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'Updated Name');
      await tester.pumpAndSettle(); // Tunggu pembaruan selesai
      expect(find.text('Updated Name'), findsOneWidget);
    });
  });
}
