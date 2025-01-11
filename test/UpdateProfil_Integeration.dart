import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/Mainpage.dart';

import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';

import 'package:provider/provider.dart';

void main() {
  late authP authsM;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    authsM = authP();
  });
  testWidgets("User menggunakan fitur update profil", (WidgetTester r) async {
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

    expect(emailF, findsOneWidget);
    expect(passwordF, findsOneWidget);
    expect(btnLogin, findsOneWidget);

    await r.enterText(emailF, email);
    await r.enterText(passwordF, password);
    await r.tap(btnLogin);

    final hasil = await authsM.login(email, password);
    print("Login result: $hasil");
    expect(hasil?['success'], true, reason: "Login failed or returned null.");
    await r.pumpAndSettle();
    final mainPage = find.byKey(Key("halamanMainpage"));
    expect(mainPage, findsOneWidget,
        reason: "Failed to navigate to Main Page.");

    final btnProfil = find.byKey(Key("tombolProfil"));
    expect(btnProfil, findsOneWidget);
    await r.tap(btnProfil);
    await r.pumpAndSettle();
    final halUpdate = find.byKey(Key("halUpdate"));
    expect(halUpdate, findsOneWidget);
    await r.tap(halUpdate);
    await r.pumpAndSettle();
  });
}
