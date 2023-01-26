import 'package:flutter/material.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';




class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Login"),
          CustomTextField(
            label: "Email",

          ),
          CustomButton(
            label: "Login",
            onPressed: () => (){
              context.read<AppState>().loginUser(User(userId: "id",username: "testing"));
              print(context.read<AppState>().isLoggedIn);
            },
          )
        ],
      )
    );
  }
}