import 'package:flutter/material.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_textfield.dart';
import 'package:kiosk/widgets/metrics_card.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //login controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //Sign up controllers
  TextEditingController store = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue,
        body: SizedBox(
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
                    CustomTextField(
                      label: "Store Name",
                      controller: store,
                    ),
                    CustomTextField(
                      label: "Full Name",
                      controller: name,
                    ),
                    CustomTextField(
                        label: "Email",
                      controller: signupEmail,
                    ),
                    CustomTextField(
                        label: "Phone number",
                        controller: number
                    ),
                    //TODO: make dropdown
                    CustomTextField(
                        label: "Country",
                        controller: country
                    ),
                    CustomTextField(
                      label: "Password",
                      controller: signupPassword,
                      obscure: true,
                    ),
                    CustomButton(
                      label: "Sign up",
                      onPressed: () async{
                        await ApiHandler.signup(
                            username: name.text,
                            phone: number.text,
                            email: signupEmail.text,
                            password: signupPassword.text,
                            storeName: store.text,
                            country: country.text
                        );
                      },
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
                      obscure: true,
                    ),
                    CustomButton(
                      label: "Login",
                      onPressed: () {
                        ApiHandler.login(context: context,email: email.text, password: password.text).then((result){
                          if (result != null){
                            Provider.of<AppState>(context,listen: false).loginUser(result);
                          }else {

                          }
                        });
                      },
                    ),





                    Text("Forgot Password",
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Text("Email taken from login form"),

                    CustomButton(
                      label: "Request password reset",
                      onPressed: (){
                        ApiHandler.generatePasswordToken(email.text).then((response){
                          print(response.body);
                        });
                      },

                    ),

                  ],
                ),
              ],
            )));
  }
}
