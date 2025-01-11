import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/pages/register.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'Auth.mocks.mocks.dart';

void main() {
  late authP authsM;

  setUp(() {
    authsM = authP();
  });

  group("Testing fitur register integration", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("User menggunakan fitur register", (WidgetTester r) async {
      String email = "amadas@gmail.com";
      String nama = "ardayudrikms";
      String password = "ardagantengbgt";
      String notelp = "0821371271";

      UserModel user = UserModel(
          email: email, nama: nama, noTelp: notelp, password: password);

      await r.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => authsM,
          child: MaterialApp(
            home: Register(),
          ),
        ),
      );

      final emailF = find.byKey(Key("inputEmail"));
      final passwordF = find.byKey(Key("inputPassword"));
      final namaF = find.byKey(Key("inputNama"));
      final notelpF = find.byKey(Key("inputNotelp"));
      final btnRegister = find.byKey(Key("btnRegister"));

      expect(emailF, findsOneWidget);
      expect(passwordF, findsOneWidget);
      expect(namaF, findsOneWidget);
      expect(notelpF, findsOneWidget);
      expect(btnRegister, findsOneWidget);

      await r.enterText(emailF, user.email);
      await r.enterText(passwordF, user.password);
      await r.enterText(namaF, user.nama);
      await r.enterText(notelpF, user.noTelp);
      await r.tap(btnRegister);
      final hasil = await authsM.buatAkun(user);
      await r.pumpAndSettle();
      expect(hasil['success'], true);

      // await r.pumpWidget(MaterialApp(
      //   home: ChangeNotifierProvider<authP>(
      //     create: (context) => authsM,
      //     child: Login(),
      //   ),
      // ));

      // when(authsM.login(email, password)).thenAnswer((s) async => {
      //       "success": true,
      //       'user': {
      //         "nama": nama,
      //         'email': email,
      //       }
      //     });
      // expect(emailF, findsOneWidget);
      // expect(passwordF, findsOneWidget);
      // final btnLogin = find.byKey(Key("btnLogin"));
      // await r.enterText(emailF, email);
      // await r.enterText(passwordF, password);
      // await r.tap(btnLogin);
      // expect(find.byKey(Key("halamanMainpage")), findsOneWidget);
      // await r.pumpAndSettle();
    });
  });
}
