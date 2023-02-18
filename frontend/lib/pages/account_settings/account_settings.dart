import "package:flutter/material.dart";
import "package:kiosk/utils/api_handler.dart";
import "package:kiosk/utils/app_state.dart";
import "package:kiosk/utils/webpage.dart";
import "package:kiosk/widgets/custom_button.dart";
import "package:kiosk/widgets/custom_textfield.dart";
import "package:provider/provider.dart";
import 'package:http/http.dart' as http;


class AccountSettings extends Webpage{
  AccountSettings() : super(large: _AccountSettingsLarge());
}





class _AccountSettingsLarge extends StatefulWidget {
  const _AccountSettingsLarge({Key? key}) : super(key: key);

  @override
  __AccountSettingsLargeState createState() => __AccountSettingsLargeState();
}

class __AccountSettingsLargeState extends State<_AccountSettingsLarge> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Account Settings"),
          Text("user ${Provider.of<AppState>(context).user.toJson()}"),



          CustomButton(
            label:"Request Email verification",
            onPressed: ()async{
              ApiHandler.requestEmailVerification(userId: context.read<AppState>().user.userId)
                  .then((value) => print(value.body));
            },
          ),

          CustomButton(
            label:"Request Phone verification",
            onPressed: ()async{
              http.Response response = await ApiHandler.requestPhoneVerification(userId: context.read<AppState>().user.userId);
              print(response.body);
            },
          ),

          CustomTextField(
            label: "Email Verification token",
            controller: email,
          ),

          CustomButton(
            label:"Verify Email",
            onPressed: ()async{
              ApiHandler.verifyEmailToken(token: email.text)
                  .then((value) => print(value.body));
            },
          ),

          CustomTextField(
              label: "Phone Verification token",
              controller: phone
          ),

          CustomButton(
            label:"Verify Phone",
            onPressed: ()async{
              ApiHandler.verifyPhoneToken(token: phone.text)
                  .then((value) => print(value.body));
            },
          ),



        ],
      ),
    );
  }
}
