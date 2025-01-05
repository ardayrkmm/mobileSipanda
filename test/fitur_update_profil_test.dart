import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/LaporModel.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/pages/UpdateProfil.dart';
import 'package:mobilecapstone/providers/LaporanP.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'Auth.mocks.mocks.dart';
import 'http_overrides.dart';
import 'lapor.mocks.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockauthP auths;

  setUp(() {
    auths = MockauthP();
    HttpOverrides.global = null;
  });

  group("testing unit", () {
    test('ketika user succes testing', () async {
      when(auths.updateProfil(
        any,
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => {'status': 'success', 'message': 'Updated'});

      final result = await auths.updateProfil(
        1,
        'arda',
        'ardyrkm23@gmail.com',
        '123456789',
        null,
      );

      expect(result['status'], 'success');
      expect(result['message'], 'Updated');
    });
    test('ketika gagal dalam melakukan update profile', () async {
      when(auths.updateProfil(
        any,
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => {'status': 'error', 'message': 'Failed'});

      final result = await auths.updateProfil(
        1,
        'arda',
        'ardyrkm23@gmail.com',
        '123456789',
        null,
      );

      expect(result['status'], 'error');
      expect(result['message'], 'Failed');
    });
  });

  group("Widget Testing", () {
    final user = UserModel(
        id: 11,
        nama: 'saipul',
        email: 'saipul22@gmail.com',
        noTelp: 'ardaganteng',
        imgProfil: "",
        password: "");
    testWidgets('Updateprofil widget renders correctly',
        (WidgetTester tester) async {
      // Dumml

      await tester.pumpWidget(
        MaterialApp(
          home: Updateprofil(usr: user),
        ),
      );

      expect(find.text('Update Profil'), findsOneWidget);
      expect(find.text('Nama'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Telepon'), findsOneWidget);

      await tester.enterText(find.byType(TextField).first, 'Updated Name');
      expect(find.text('Updated Name'), findsOneWidget);
    });
  });
}
