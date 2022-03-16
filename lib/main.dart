import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/screen/about_page.dart';
import 'package:invoice_flutter/page/screen/category_list_page.dart';
import 'package:invoice_flutter/page/screen/create_customer_page.dart';
import 'package:invoice_flutter/page/screen/create_invoice_page.dart';
import 'package:invoice_flutter/page/screen/customer_list_page.dart';
import 'package:invoice_flutter/page/screen/dashboard_page.dart';
import 'package:invoice_flutter/page/screen/home_page.dart';
import 'package:invoice_flutter/page/screen/invoice_list_page.dart';
import 'package:invoice_flutter/page/screen/login_page.dart';
import 'package:invoice_flutter/page/screen/product_list_page.dart';
import 'package:invoice_flutter/page/screen/profile_page.dart';
import 'package:invoice_flutter/page/screen/report_page.dart';
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
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.signupRoute: (context) => SignUpPage(),

        // MyRoutes.dashboard: (context) => Dashboard(),
        // MyRoutes.invoiceListRoute: (context) => InvoiceListPage(),
        // MyRoutes.productsRoute: (context) => ProductsPage(),
        // MyRoutes.customersRoute: (context) => CustomersPage(),
        // MyRoutes.categoriesRoute: (context) => CategoriesPage(),
        //
        // MyRoutes.profileRoute: (context) => ProfileUI2(),
        //
        // MyRoutes.newInvoiceRoute: (context) => CreateInviocePage(),
        // MyRoutes.addCustomerRoute: (context) => CreateCustomer(),
        //
        // MyRoutes.aboutRoute: (context) => AboutPage(),
        // MyRoutes.reportRoute: (context) => ReportPage(),

      }
    );
  }
}
