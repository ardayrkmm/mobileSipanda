import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/pages/chatbot.dart';
import 'package:mobilecapstone/providers/chatbot.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'mocks.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late chatbotProvider chatBotP;
  late MockClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockClient();
    chatBotP = chatbotProvider();
    chatBotP.httpClient = mockHttpClient;
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Penggunaan user menggunnakan fitur chatbot",
      (WidgetTester f) async {
    when(mockHttpClient.post(
      Uri.parse('${Config.urlBase}/api/chatbot/mobile'),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(
          jsonEncode({'response': ''}),
          200,
        ));

    await f.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => chatBotP,
          child: ChatBot(),
        ),
      ),
    );

    await f.enterText(find.byType(TextFormField), 'sipanda yaitu');
    await f.tap(find.byType(IconButton));
    await f.pump();

    expect(find.text('sipanda yaitu'), findsOneWidget);

    chatBotP.addBotMessage(
        'sipanda yaitu masyarakat lokal dalam menjaga keberagaman hayati dengan mengintegrasikan data dan mengidentifikasi spesies yang terancam punah. sekitar kawasan konserv');
    await f.pump();

    expect(
        find.text(
            'sipanda yaitu masyarakat lokal dalam menjaga keberagaman hayati dengan mengintegrasikan data dan mengidentifikasi spesies yang terancam punah. sekitar kawasan konserv'),
        findsOneWidget);
  });
}
