import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/HalamanScan.dart';
import 'package:mobilecapstone/providers/scanProvider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'scan.mocks.mocks.dart';
import 'camera_controller_mock.dart';

void main() {
  late MockscanProvider scansP;

  setUp(() {
    scansP = MockscanProvider();
  });
  group("unit Testing Fitur Scan", () {
    test("Input gambar berhasil", () async {
      final file = File("C:\Users\LENOVO\Downloads\badaks.jpg");

      final mockResponse = {
        'status': 'success',
        'result': 'dilindungi',
        'url_gambar': 'C:\Users\LENOVO\Downloads\badaks.jpg"'
      };

      when(scansP.tambahGambar(file)).thenAnswer((_) async => mockResponse);

      final result = await scansP.tambahGambar(file);

      expect(result['status'], 'success');
      expect(result['result'], mockResponse['result']);
      expect(result['url_gambar'], mockResponse['url_gambar']);

      verify(scansP.tambahGambar(file)).called(1);
    });
    test('tambahGambar dengan input salah atau gagal', () async {
      final file = File('C:/Users/LENOVO/Downloads/badaks.jpg');
      final mockResponse = {
        'status': 'error',
        'result': 'dilindungi',
        'message': 'File tidak valid',
        'url_gambar': 'C:/Users/LENOVO/Downloads/badaks.jpg'
      };

      when(scansP.tambahGambar(file)).thenAnswer((_) async => mockResponse);

      final result = await scansP.tambahGambar(file);

      expect(result['status'], 'error');
      expect(result['message'], isNotNull);
      expect(result['message'], isNotEmpty);
      verify(scansP.tambahGambar(any)).called(1);
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
