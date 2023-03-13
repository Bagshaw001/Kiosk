import 'package:flutter/material.dart';
import 'package:kiosk/utils/user.dart';



class AppState extends ChangeNotifier {
  // User? _user ;
  User? _user = User(userId: "024582395e8429238871dbacb88221bc", username: "kweku acquaye",
      storeId: "be53953f6d9a979d34a265547f962448", storeName: "Amelia", email: "kweku.acquaye@ashesi.edu.gh", profileImage: null);

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
