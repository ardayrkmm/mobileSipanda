import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecapstone/pages/HalamanScan.dart';
import 'package:mobilecapstone/providers/scanProvider.dart';
import 'package:provider/provider.dart';

import 'fitur_update_profil_test.dart';

void main() {
  late scanProvider scansP;

  setUp(() {
    scansP = scanProvider();
    HttpOverrides.global = MyHttpOverrides();
  });

  group("Unit Testing Fitur Scan", () {
    test("Input gambar berhasil", () async {
      final file = File("C:/Users/LENOVO/Downloads/badaks.jpg");

      final result = await scansP.tambahGambar(file);

      expect(result['status'], 'success');
      expect(result['result'], isNotEmpty);
      expect(result['url_gambar'], isNotEmpty);
    });

    test('tambahGambar dengan input salah atau gagal', () async {
      final file = File(
          'C:/Users/LENOVO/Downloads/nonexistent.jpg'); // File tidak valid atau tidak ada

      final result = await scansP.tambahGambar(file);

      expect(result['status'], 'error');
      expect(result['message'], isNotNull);
      expect(result['message'], isNotEmpty);
    });
  });

  group("Testing widgets fitur scan", () {
    testWidgets(
        'Menampilkan CircularProgressIndicator saat kamera belum diinisialisasi',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<scanProvider>.value(
          value: scansP,
          child: const MaterialApp(
            home: HalamanScan(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
