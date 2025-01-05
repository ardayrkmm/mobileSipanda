import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }
}
