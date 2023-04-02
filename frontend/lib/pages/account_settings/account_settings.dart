import "package:flutter/material.dart";
import "package:kiosk/pages/account_settings/settings_pages/manage_collaborators_settings.dart";
import "package:kiosk/pages/account_settings/settings_pages/store_profile_settings.dart";
import "package:kiosk/pages/account_settings/settings_pages/withdrawal_settings.dart";
import "package:kiosk/utils/api_handler.dart";
import "package:kiosk/utils/app_state.dart";
import "package:kiosk/utils/constants.dart";
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
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //Nav tab
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.withOpacity(0.5),
              child: Column(
                children: [

                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 70,
                        height: 70,
                      ),

                      const Spacer(),
                      IconButton(
                        icon:const Icon(Icons.account_circle_rounded),
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> AccountSettings().large
                              )
                          );

                        },
                      ),


                      IconButton(
                        icon:const Icon(Icons.notifications),
                        onPressed: (){

                        },
                      ),
                    ],
                  ),

                  Text("Account Settings",
                    style: Theme.of(context).textTheme.bodyMedium!
                        .copyWith(color: Colors.white),),

                  _SettingsTile(
                    label: "Store Profile",
                    selected: currentPage == 0,
                    onPressed: (){
                      pageController.jumpToPage(0);
                    },

                  ),

                  _SettingsTile(
                    label: "Withdrawals",
                    selected: currentPage == 1,
                    onPressed: (){
                      setState(() {
                        pageController.jumpToPage(1);
                      });

                    },
                  ),

                  _SettingsTile(
                    label: "Manage Collaborators",
                    selected: currentPage == 2,
                    onPressed: (){
                      pageController.jumpToPage(2);
                    },
                  ),


                  _SettingsTile(
                    label: "Log Out",
                    selected: currentPage == 3,
                    onPressed: (){
                      // context.read<AppState>().logout();

                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  )

                ],
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child:PageView.builder(

              itemBuilder: (context,e){
                return const [
                  WithdrawalSettings(),
                  StoreProfileSettings(),
                  ManageCollaboratorsSettings()
                ][e];
              },
              controller: pageController,
              onPageChanged: (selected){
                print(selected);
                setState(() {

                });
              },
            ),
          )
        ],
      ),
    );
  }
}





class _SettingsTile extends StatelessWidget {
  final String label;
  final bool selected;
  final Function() onPressed;
  const _SettingsTile({
    required this.label,
    required this.selected,
    required this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.maxFinite,
        padding: const EdgeInsets.only(left:30,) + const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selected ? blue : Colors.black38
        ),
        child: Text(label),
      ),
    );
  }
}
