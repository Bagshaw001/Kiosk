import 'package:flutter/material.dart';
import 'package:kiosk/pages/authentication/request_password_reset.dart';
import 'package:kiosk/pages/authentication/sign_up.dart';
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
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/logo.png", width: double.maxFinite,
                        fit: BoxFit.fitWidth,)
                      ],
                    )
                ),
                Expanded(
                  child: Column(
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

                      TextButton(
                          child: const Text("Sign up instead"),
                          onPressed: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context)=> SignUp()));
                          }
                      ),
                      TextButton(
                          child: const Text("Forgot password? Request a reset"),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> RequestPasswordReset()));
                          }
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
