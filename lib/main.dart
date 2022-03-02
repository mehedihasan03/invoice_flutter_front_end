import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/screen/dashboard_page.dart';
import 'package:invoice_flutter/page/screen/home_page.dart';
import 'package:invoice_flutter/page/screen/login_page.dart';
import 'package:invoice_flutter/page/screen/profile_page.dart';
import 'package:invoice_flutter/page/screen/sign_up_page.dart';
import 'package:invoice_flutter/utils/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'INVOICE';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.loginRoute,
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.dashboard: (context) => Dashboard(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.signupRoute: (context) => SignUpPage(),
        MyRoutes.signupRoute: (context) => ProfileUI2(),
      }
    );
  }
}
