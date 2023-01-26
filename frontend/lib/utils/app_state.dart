import 'package:flutter/material.dart';

class User {
  String userId;
  String username;

  User({required this.userId, required this.username});
}

class AppState extends ChangeNotifier {
  User? _user;

  Future<bool> loginUser(
      {required String email, required String password}) async {
    _user = User(userId: "userId", username: "username");
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
  User? get user => _user;
}
