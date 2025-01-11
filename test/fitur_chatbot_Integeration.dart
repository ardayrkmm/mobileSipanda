import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/pages/chatbot.dart';
import 'package:mobilecapstone/providers/chatbot.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

void main() {
  late chatbotProvider chatBotP;

  setUp(() {
    chatBotP = chatbotProvider();
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Penggunaan user menggunnakan fitur chatbot",
      (WidgetTester f) async {
    await f.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => chatBotP,
        child: MaterialApp(
          home: ChatBot(),
        ),
      ),
    );

    final Finder inputField = find.byType(TextFormField);
    final Finder sendButton = find.byType(IconButton);

    await f.enterText(inputField, 'makanan harimau sumatra');
    await f.pump();

    await f.tap(sendButton);
    await f.pump();

    expect(find.text('makanan harimau sumatra'), findsOneWidget);

    await f.pump(Duration(seconds: 4));
    expect(
        find.text(
            'Harimau Sumatra memakan hewan besar dan juga kadang memakan hewan kecil seperti burung, monyet, dan kadal.'),
        findsOneWidget);
  });
}
