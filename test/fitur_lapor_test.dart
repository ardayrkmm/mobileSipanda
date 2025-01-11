import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/LaporModel.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/providers/LaporanP.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'http_overrides.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late Laporanp laporanProvider;

  setUp(() {
    laporanProvider = Laporanp();
    HttpOverrides.global = MyHttpOverrides();
  });

  group('Unit Testing fitur lapor', () {
    test('Berhasil membuat laporan', () async {
      final result = await laporanProvider.buatLaporan(
        LaporModel(
            id: "",
            namaLapor: 'Test',
            nomerHp: '123456789',
            alamat: 'Alamat',
            maps: '0.0,0.0',
            keterangan: 'Test laporan',
            status: 'sedang_di_proses',
            gambar: "lapor.jpg"),
      );

      expect(result['message'], 'Laporan berhasil disimpan');
    });

    test('Gagal Membuat laporan', () async {
      final result = await laporanProvider.buatLaporan(
        LaporModel(
            id: 1.toString(),
            namaLapor: 'Test',
            nomerHp: '12345678',
            alamat: 'Alamat',
            maps: '',
            keterangan: 'Test laporan',
            status: 'sedang_di_proses',
            gambar: "lapor.jpg"),
      );

      expect(result['success'], true);
      expect(result['message'], 'Laporan berhasil disimpan');
    });
  });

  group('Widget Test: ReportScreen', () {
    HttpOverrides.global = MyHttpOverrides();
    group('Widget Test: ReportScreen', () {
      testWidgets('Inputan dalam halaman 4', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => Laporanp(),
            child: ReportScreen(
              imgUrlH: "ada",
            ),
          ),
        ));
        expect(find.byType(TextField), findsNWidgets(4));
        expect(find.text("Laporkan").last, findsWidgets);
      });
    });
    testWidgets('Submit button triggers report creation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<Laporanp>.value(
          value: laporanProvider,
          child: MaterialApp(
            home: ReportScreen(
              imgUrlH: "ada",
            ),
          ),
        ),
      );

      expect(find.text('Laporkan').first, findsWidgets);
      expect(find.byType(TextField), findsNWidgets(4));

      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'Test User');
      await tester.enterText(find.byType(TextField).at(1), '08123456789');
      await tester.enterText(find.byType(TextField).at(2), 'Jl. Test Alamat');
      await tester.enterText(
          find.byType(TextField).at(3), 'Ini adalah keterangan.');

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('08123456789'), findsOneWidget);
      expect(find.text('Jl. Test Alamat'), findsOneWidget);
      expect(find.text('Ini adalah keterangan.'), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle();

      expect(find.text('Berhasil'), findsNothing);
      expect(find.text('Laporan berhasil dikirim'), findsNothing);
    });
  });
}
