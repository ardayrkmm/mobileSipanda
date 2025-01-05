import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/SentimenM.dart';
import 'package:http/http.dart' as http;

class SentimenProvider extends ChangeNotifier {
  SentimentModel? _sentimentModel;

  SentimentModel? get sentimenResponse => _sentimentModel;

  Future<void> TambahKomen(String komen) async {
    try {
      final url = Uri.parse('${Config.urlBase}/api/komen');
      final ress = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"comment": komen}));

      if (ress.statusCode == 201) {
        _sentimentModel = json.decode(ress.body);
        notifyListeners();
      } else {
        throw Exception('Failed to add comment');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
