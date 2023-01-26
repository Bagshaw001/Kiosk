import 'package:flutter/material.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
            width: size.width,
            height: size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Sign up",
                        style: Theme.of(context).textTheme.headlineMedium),
                    CustomTextField(label: "Full Name"),
                    CustomTextField(label: "Email"),
                    CustomTextField(label: "Phone number"),
                    CustomTextField(
                      label: "Password",
                      obscure: true,
                    ),
                    CustomButton(
                      label: "Sign up",
                      onPressed: () {},
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Login",
                        style: Theme.of(context).textTheme.headlineMedium),
                    CustomTextField(
                      label: "Email",
                      controller: email,
                    ),
                    CustomTextField(
                      label: "Password",
                      controller: password,
                    ),
                    CustomButton(
                      label: "Login",
                      onPressed: () async{
                        Provider.of<AppState>(context,listen: false).loginUser(
                            email: email.text, password: password.text).then((success){
                              if (success){
                                Navigator.popUntil(context, (route) => route.isFirst);
                              }
                            });
                      },
                    )
                  ],
                ),
              ],
            )));
  }
}
