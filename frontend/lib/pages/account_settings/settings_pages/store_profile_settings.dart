import "package:flutter/material.dart";
import "package:kiosk/utils/api_handler.dart";
import "package:kiosk/widgets/custom_button.dart";
import "package:kiosk/widgets/custom_textfield.dart";


class StoreProfileSettings extends StatefulWidget {
  const StoreProfileSettings({Key? key}) : super(key: key);

  @override
  _StoreProfileSettingsState createState() => _StoreProfileSettingsState();
}

class _StoreProfileSettingsState extends State<StoreProfileSettings> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Account Settings"),
        Text("user Provider.of<AppState>(context).user.toJson()}"),

        Row(
          children: [
            Icon(Icons.account_circle_rounded, size: 30,),
            Text("Store name"),

          ],
        ),

        Row(
          children: [
            Text("main.easygo@gmail.com"),
            false ?
            const Icon(Icons.verified_user, color: Colors.green,)
                :
            CustomButton(
              filled: false,
              label: "Verify email",
              onPressed: (){

              },
            )
          ],
        ),

        Row(
          children: [
            Text("0559582518"),
            false ?
            const Icon(Icons.verified_user, color: Colors.green,)
                :
            CustomButton(
              filled: false,
              label: "Verify phone",
              onPressed: (){

              },
            )
          ],
        ),





        // CustomButton(
        //   label:"Request Email verification",
        //   onPressed: ()async{
        //     // ApiHandler.requestEmailVerification(userId: context.read<AppState>().user.userId)
        //     //     .then((value) => print(value.body));
        //   },
        // ),
        //
        // CustomButton(
        //   label:"Request Phone verification",
        //   onPressed: ()async{
        //     // http.Response response = await ApiHandler.requestPhoneVerification(userId: context.read<AppState>().user.userId);
        //     // print(response.body);
        //   },
        // ),
        //
        // CustomTextField(
        //   label: "Email Verification token",
        //   controller: email,
        // ),
        //
        // CustomButton(
        //   label:"Verify Email",
        //   onPressed: ()async{
        //     ApiHandler.verifyEmailToken(token: email.text)
        //         .then((value) => print(value.body));
        //   },
        // ),
        //
        // CustomTextField(
        //     label: "Phone Verification token",
        //     controller: phone
        // ),
        //
        // CustomButton(
        //   label:"Verify Phone",
        //   onPressed: ()async{
        //     ApiHandler.verifyPhoneToken(token: phone.text)
        //         .then((value) => print(value.body));
        //   },
        // ),



      ],
    );
  }
}


