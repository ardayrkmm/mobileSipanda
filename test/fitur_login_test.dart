import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'Auth.mocks.mocks.dart';

void main() {
  late MockauthP authsM;

  setUp(() {
    authsM = MockauthP();
  });
  group("testing fungsi dari login", () {
    test("testing ketika user melakukan login dengan benar", () async {
      String email = "ardyrkm23@gmail.com";
      String password = "ardagantengbgt";
      when(authsM.login(email, password)).thenAnswer((s) async => {
            "success": true,
            'user': {
              'id': 1,
              "nama": "ardaUpdateS update",
              'email': 'ardyrkm23@gmail.com',
            }
          });
      final hasil = await authsM.login(email, password);

      expect(hasil['success'], true);
      expect(hasil['user']['email'], 'ardyrkm23@gmail.com');
    });

    test("testing ketika user melakukan login email salah", () async {
      String email = "ardyrkm23s@gmail.com";
      String password = "ardagantengbgt";
      when(authsM.login(email, password)).thenAnswer((s) async => {
            "success": false,
            'user': {
              'id': 1,
              "nama": "ardaUpdateS update",
              'email': 'ardyrkm23@gmail.com',
            }
          });
      final hasil = await authsM.login(email, password);

      expect(hasil['success'], false);
    });
    test("testing ketika user melakukan login password salah", () async {
      String email = "ardyrkm23@gmail.com";
      String password = "ardaganten";
      when(authsM.login(email, password)).thenAnswer((s) async => {
            "success": false,
            'user': {
              'id': 1,
              "nama": "ardaUpdateS update",
              'email': 'ardyrkm23@gmail.com',
            }
          });
      final hasil = await authsM.login(email, password);

      expect(hasil['success'], false);
    });

    test("testing ketika user melakukan login dengan inputan kosong", () async {
      String email = "";
      String password = "";
      when(authsM.login(email, password)).thenAnswer((s) async => {
            "success": false,
            'user': {
              'id': 1,
              "nama": "ardaUpdateS update",
              'email': 'ardyrkm23@gmail.com',
            }
          });
      final hasil = await authsM.login(email, password);

      expect(hasil['success'], false);
    });
  });

  group("Testing widget fitur login", () {
    testWidgets("Test input email dan password", (WidgetTester r) async {
      await r.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => authP(),
          child: Login(),
        ),
      ));

      expect(find.byType(TextField).first, findsOneWidget);
      expect(find.text("Masukan Email"), findsWidgets);
      expect(find.byType(TextField).last, findsOneWidget);
      expect(find.text("Masukan Password"), findsWidgets);
      expect(find.text("Login").last, findsWidgets);
    });

    testWidgets("Test tombol login", (WidgetTester r) async {
      await r.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => authP(),
          child: Login(),
        ),
      ));
      await r.enterText(find.byType(TextField).first, "ardyrkm23@gmail.com");
      await r.enterText(find.byType(TextField).last, "ardagantengbgt");

      await r.tap(find.text('Login').last);
      await r.pump();

      expect(find.text('Login'), findsWidgets);
    });
  });
}
