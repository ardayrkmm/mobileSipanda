import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/pages/chatbot.dart';
import 'package:mobilecapstone/providers/chatbot.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'mocks.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  group("test fitur chatbotprovider unit tests", () {
    late chatbotProvider chatBotP;
    late MockClient mockHttpClient;
    setUp(() {
      mockHttpClient = MockClient();
      chatBotP = chatbotProvider();
      chatBotP.httpClient = mockHttpClient;
    });

    test("user melakukan pertayaan ", () {
      chatBotP.addUserMessage("sipanda yaitu");
      expect(chatBotP.messages.length, 1);
      expect(chatBotP.messages.first['text'], "sipanda yaitu");
      expect(chatBotP.messages.first['bot'], false);
    });

    test("bot sipanda menjawab user ", () {
      chatBotP.addBotMessage(
          "sipanda yaitu masyarakat lokal dalam menjaga keberagaman hayati dengan mengintegrasikan data dan mengidentifikasi spesies yang terancam punah. sekitar kawasan konserv");
      expect(chatBotP.messages.length, 1);
      expect(chatBotP.messages.first['text'],
          "sipanda yaitu masyarakat lokal dalam menjaga keberagaman hayati dengan mengintegrasikan data dan mengidentifikasi spesies yang terancam punah. sekitar kawasan konserv");
      expect(chatBotP.messages.first['bot'], true);
    });

    test("cek konek ke server", () async {
      // Mock response dari server
      when(mockHttpClient.post(
        Uri.parse('${Config.urlBase}/api/chatbot/mobile'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            jsonEncode({'response': 'Sipanda menjawab dengan benar'}),
            200,
          ));

      await chatBotP.sendMessage('sipanda yaitu');

      expect(chatBotP.messages.length, 1);
      expect(chatBotP.messages.last['text'], 'Sipanda menjawab dengan benar');
    });
  });

  group("Widget Testing fitur chatbot", () {
    late chatbotProvider chatBotP;
    late MockClient mockHttpClient;
    setUp(() {
      mockHttpClient = MockClient();
      chatBotP = chatbotProvider();
      chatBotP.httpClient = mockHttpClient;
    });

    testWidgets("Test input dan tombol kirim pesan di fitur chatbot",
        (WidgetTester r) async {
      await r.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => chatbotProvider(),
          child: ChatBot(),
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);

      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets("Ketika melakukan mengirim pesan ke bot",
        (WidgetTester r) async {
      when(mockHttpClient.post(
        Uri.parse('${Config.urlBase}/api/chatbot/mobile'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            jsonEncode({'response': 'Sipanda menjawab dengan benar'}),
            200,
          ));

      await r.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => chatBotP,
            child: ChatBot(),
          ),
        ),
      );

      await r.enterText(find.byType(TextField), "sipanda yaitu");
      await r.tap(find.byType(IconButton));
      await r.pump();

      expect(chatBotP.messages.length, 2);
      expect(chatBotP.messages.first["text"], "sipanda yaitu");
      expect(chatBotP.messages.last["text"], "Sipanda menjawab dengan benar");
    });
  });

  group("Testing integration fitur chatbot", () {
    late chatbotProvider chatBotP;
    late MockClient mockHttpClient;
    setUp(() {
      mockHttpClient = MockClient();
      chatBotP = chatbotProvider();
      chatBotP.httpClient = mockHttpClient;
    });

    testWidgets("Penggunaan user menggunnakan fitur chatbot",
        (WidgetTester f) async {
      when(mockHttpClient.post(
        Uri.parse('${Config.urlBase}/api/chatbot/mobile'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            jsonEncode({'response': 'Sipanda menjawab dengan benar'}),
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
  });
}
