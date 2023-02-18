import 'package:flutter/material.dart';
import 'package:kiosk/utils/user.dart';



class AppState extends ChangeNotifier {
  User? _user;


  void loginUser(User newUser){
    _user = newUser;
    notifyListeners();
  }



  void logout() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
  User get user => _user!;
}
