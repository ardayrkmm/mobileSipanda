import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobilecapstone/config.dart';
import 'package:http/http.dart' as http;

class chatbotProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;

  void addUserMessage(String message) {
    _messages.add({'text': message, 'bot': false});
    notifyListeners();
  }

  void addBotMessage(String message) {
    _messages.add({'text': message, 'bot': true});
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    final url = Uri.parse('${Config.urlBase}/api/chatbot/mobile');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        addBotMessage(responseBody['response']);
      } else {
        addBotMessage('Error: ${response.statusCode}');
      }
    } catch (e) {
      addBotMessage('Failed to connect to server.');
    }
  }
}
