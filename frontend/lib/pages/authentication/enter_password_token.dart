import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kiosk/utils/api_handler.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/widgets/custom_textfield.dart';


class EnterPasswordToken extends StatelessWidget {
  EnterPasswordToken({Key? key}) : super(key: key);
  final TextEditingController token = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

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
                  const Text("Check your email for the reset token"),
                  CustomTextField(
                    controller: token,
                  ),
                  CustomTextField(
                    controller: password,
                  ),

                  CustomTextField(
                    controller: confirmPassword,
                  ),

                  CustomButton(
                      label: "Reset Password",
                    onPressed: (){
                        ApiHandler.resetPassword(
                            password: password.text,
                            token: token.text
                        ).then((result){
                          Map<String,dynamic> json = jsonDecode(result.body);
                            showDialog(context: context, builder: (context)=> Dialog(
                              child: Text(json["response"]["msg"]),
                            ));
                        });
                    },
                  ),

                  TextButton(
                    child: const Text("Proceed to login screen"),
                    onPressed: (){
                      Navigator.popUntil(context, (route) => route.isFirst);
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
