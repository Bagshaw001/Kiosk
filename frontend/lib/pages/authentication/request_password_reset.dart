import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kiosk/pages/authentication/enter_password_token.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_textfield.dart';
import 'package:kiosk/widgets/error_dialog.dart';


class RequestPasswordReset extends StatelessWidget {
   RequestPasswordReset({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
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
                children: [

                  Text("Forgot Password",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Text("Email taken from login form"),

                  CustomTextField(
                    label: "Email",
                    controller: email,
                  ),

                  CustomButton(
                    label: "Request password reset",
                    onPressed: (){
                      ApiHandler.generatePasswordToken(email.text).then((response){
                        Map<String,dynamic> json = jsonDecode(response.body);

                        if (json["statusCode"] == 200){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> EnterPasswordToken()
                              )
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (context)=> ErrorDialog(text: json["response"]["msg"]));
                        }
                      });
                    },

                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
