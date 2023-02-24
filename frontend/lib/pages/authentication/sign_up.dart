import 'package:flutter/material.dart';
import 'package:kiosk/pages/authentication/login.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Sign up controllers
  TextEditingController store = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
            children: [

              //Image column

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


              //Form column

        Expanded(
          child: Column(
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
              ),
              TextButton(
                child: const Text("Log in instead"),
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=> const LoginPage()));
                },
              )
            ],
          ),
        ),


            ]
        )
    );
  }
}
