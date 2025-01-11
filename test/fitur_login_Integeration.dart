import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';

import 'package:provider/provider.dart';

void main() {
  late authP authsM;

  setUp(() {
    authsM = authP();
  });
  group("Testing fitur login integration", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("User menggunakan fitur login", (WidgetTester r) async {
      String email = "fajarajah322@gmail.com";
      String password = "fajar320";

      await r.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider(
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
      await r.enterText(emailF, email);
      await r.enterText(passwordF, password);
      await r.tap(btnLogin);
      final hasil = await authsM.login(email, password);
      await r.pumpAndSettle();

      expect(find.byKey(Key("halamanMainpage")), findsOneWidget);
    });
  });
}
