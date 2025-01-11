import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/providers/LaporanP.dart';
import 'package:provider/provider.dart';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Laporanp laporanProvider;

  setUp(() {
    laporanProvider = Laporanp();
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Submit button triggers report creation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => laporanProvider,
        child: MaterialApp(
          home: ReportScreen(
            imgUrlH: "ada",
          ),
        ),
      ),
    );

    // Lakukan interaksi dan pengecekan
    await tester.enterText(find.byType(TextField).at(0), 'Test User');
    await tester.enterText(find.byType(TextField).at(1), '08123456789');
    await tester.enterText(find.byType(TextField).at(2), 'Jl. Test Alamat');
    await tester.enterText(
        find.byType(TextField).at(3), 'Ini adalah keterangan.');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Berhasil'), findsNothing);
  });
}
