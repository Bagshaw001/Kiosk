import 'package:flutter/material.dart';
import 'package:kiosk/pages/accounts/accounts.dart';
import 'package:kiosk/pages/authentication/login.dart';
import 'package:kiosk/pages/dashboard/dashboard.dart';
import 'package:kiosk/pages/inventory/inventory.dart';
import 'package:kiosk/pages/statistics/statistics.dart';
import 'package:kiosk/pages/transactions/transactions.dart';
import 'package:kiosk/utils/app_state.dart';
import 'package:kiosk/utils/theme.dart';
import 'package:kiosk/utils/webpage.dart';
import 'package:kiosk/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp( const MyApp());
  runApp(ChangeNotifierProvider<AppState>(
    create: (context) => AppState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home:
          Provider.of<AppState>(context).isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 1;
  final List<Webpage> pages = [
    Dashboard(),
    Inventory(),
    Transactions(),
    Accounts(),
    Statistics(),
  ];

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
        selectedIndex: _current,
        mainPage: pages[_current],
        onNavClick: (navIndex) => setState(() => _current = navIndex));
  }
}
