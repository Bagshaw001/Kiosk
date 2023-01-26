
import 'package:flutter/material.dart';

class User{
  String userId;
  String username;

  User({
    required this.userId,
  required this.username
  });
}

class AppState extends ChangeNotifier{
  User? user;

  void loginUser(usere){
    user = usere;
    print("Login");
    notifyListeners();
  }


  void logout(){
    user = null;
    notifyListeners();
  }


  bool get isLoggedIn => user != null;


}