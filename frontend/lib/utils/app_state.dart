import 'package:flutter/material.dart';
import 'package:kiosk/utils/user.dart';



class AppState extends ChangeNotifier {
  User? _user;


  void loginUser(User newUser){
    _user = newUser;
    print("User logged in ${_user!.storeId}, ${_user!.userId}, ${_user!.userId}");
    notifyListeners();
  }



  void logout() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
  User get user => _user!;
}
