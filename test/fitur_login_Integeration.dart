import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobilecapstone/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'Auth.mocks.mocks.dart';

void main() {
  late MockauthP authsM;

  setUp(() {
    authsM = MockauthP();
    HttpOverrides.global = null;
  });
  group("Testing fitur login integration", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("User menggunakan fitur login", (WidgetTester r) async {
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
      await r.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<authP>(
          create: (context) => authsM,
          child: Login(),
        ),
      ));

      final emailF = find.byKey(Key("inputEmail"));
      final passwordF = find.byKey(Key("inputPassword"));
      final btnLogin = find.byKey(Key("tombolLogin"));
      print("Finding widgets...");
      expect(emailF, findsOneWidget);
      expect(passwordF, findsOneWidget);
      expect(btnLogin, findsOneWidget);
      print("ditemukan...");
      await r.enterText(emailF, "ardyrkm23@gmail.com");
      await r.enterText(passwordF, "ardagantengbgt");
      await r.tap(btnLogin);

      await r.pumpAndSettle();

      expect(find.byKey(Key("halamanMainpage")), findsOneWidget);
    });
  });
}
