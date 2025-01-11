import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/pages/chatbot.dart';
import 'package:mobilecapstone/providers/chatbot.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import 'fitur_update_profil_test.dart';

void main() {
  late chatbotProvider chatBotP;

  setUp(() {
    chatBotP = chatbotProvider();
    HttpOverrides.global = MyHttpOverrides();
  });
  group("test fitur chatbotprovider unit tests", () {
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
  });

  group("Widget Testing fitur chatbot", () {
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
        (WidgetTester tester) async {
      // Inisialisasi widget
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => chatbotProvider(),
            child: ChatBot(),
          ),
        ),
      );

      // Masukkan teks ke TextField
      await tester.enterText(find.byType(TextField), "assalamualaikum");

      // Klik tombol kirim (IconButton)
      await tester.tap(find.byType(IconButton));

      // Tunggu pembaruan UI dan respons selesai
      await tester.pumpAndSettle();

      // Ambil instance chatbotProvider
      // final chatBotP = Provider.of<chatbotProvider>(
      //     tester.element(find.byType(ChatBot)),
      //     listen: true);

      // // Verifikasi jumlah pesan
      // expect(chatBotP.messages.length, 2);

      // // Verifikasi isi pesan
      // expect(chatBotP.messages.first["text"], "assalamualaikum");
      // expect(chatBotP.messages.last["text"], "Waalaikumsalam");
    });
  });

  // group("Testing integration fitur chatbot", () {
  //   late chatbotProvider chatBotP;

  //   setUp(() {
  //     chatBotP = chatbotProvider();
  //   });

  //   testWidgets("Penggunaan user menggunnakan fitur chatbot",
  //       (WidgetTester f) async {
  //     await f.pumpWidget(
  //       MaterialApp(
  //         home: ChangeNotifierProvider(
  //           create: (context) => chatBotP,
  //           child: ChatBot(),
  //         ),
  //       ),
  //     );

  //     await f.enterText(find.byType(TextFormField), 'sipanda yaitu');
  //     await f.tap(find.byType(IconButton));
  //     await f.pump();

  //     expect(find.text('sipanda yaitu'), findsOneWidget);

  //     chatBotP.addBotMessage(
  //         'sipanda yaitu masyarakat lokal dalam menjaga keberagaman hayati dengan mengintegrasikan data dan mengidentifikasi spesies yang terancam punah. sekitar kawasan konserv');
  //     await f.pump();

  //     expect(
  //         find.text(
  //             'sipanda yaitu masyarakat lokal dalam menjaga keberagaman hayati dengan mengintegrasikan data dan mengidentifikasi spesies yang terancam punah. sekitar kawasan konserv'),
  //         findsOneWidget);
  //   //   });
  // });
}
