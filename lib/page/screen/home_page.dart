import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/screen/about_page.dart';
import 'package:invoice_flutter/page/screen/create_customer_page.dart';
import 'package:invoice_flutter/page/screen/invoice_list_page.dart';
import 'package:invoice_flutter/page/screen/profile_page.dart';
import 'package:invoice_flutter/page/screen/report_page.dart';
import 'package:invoice_flutter/utils/routes.dart';

import 'bottom_navigation_page.dart';
import 'create_invoice_page.dart';
import 'dashboard_page.dart';
import 'drawer_header_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;
  int _selectedIndex = 0;
  List<Widget> pages = [
    Dashboard(),
    CreateInviocePage(),
    InvoiceListPage(),
    CreateCustomer(),
    ProfileUI2(),
    AboutPage(),
    ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = Dashboard();
    } else if (currentPage == DrawerSections.createInvoice) {
      container = CreateInviocePage();
    } else if (currentPage == DrawerSections.invoiceList) {
      container = InvoiceListPage();
    } else if (currentPage == DrawerSections.profile) {
      container = ProfileUI2();
    } else if (currentPage == DrawerSections.createCustomer) {
      container = CreateCustomer();
    } else if (currentPage == DrawerSections.report) {
      container = ReportPage();
    } else if (currentPage == DrawerSections.about) {
      container = AboutPage();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
        title: Text("Invoice Management"),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
                  icon: Icon(Icons.search))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.print_sharp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.fullscreen),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ),
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Invoices", Icons.event,
              currentPage == DrawerSections.invoiceList ? true : false),
          Divider(
            thickness: 2,
          ),
          menuItem(3, "New Invoice", Icons.add_shopping_cart,
              currentPage == DrawerSections.createInvoice ? true : false),
          menuItem(4, "Add Customer", Icons.person_add_alt_1_rounded,
              currentPage == DrawerSections.createCustomer ? true : false),
          Divider(
            thickness: 2,
          ),
          menuItem(5, "Profile", Icons.person_pin_outlined,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(6, "About", Icons.web,
              currentPage == DrawerSections.about ? true : false),
          Divider(
            thickness: 2,
          ),
          menuItem(7, "Report", Icons.report_problem_outlined,
              currentPage == DrawerSections.report ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.invoiceList;
            } else if (id == 3) {
              currentPage = DrawerSections.createInvoice;
            } else if (id == 4) {
              currentPage = DrawerSections.createCustomer;
            } else if (id == 5) {
              currentPage = DrawerSections.profile;
            } else if (id == 6) {
              currentPage = DrawerSections.about;
            } else if (id == 7) {
              currentPage = DrawerSections.report;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  createInvoice,
  invoiceList,
  profile,
  createCustomer,
  report,
  about,
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(49, 87, 110, 1.0),
              ),
              child: Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.account_balance_wallet_outlined),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Create Invoice"),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateInviocePage()));
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.list_alt_outlined),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Invoices"),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InvoiceListPage()));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("My Profile"),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileUI2()));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.web_outlined),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("About "),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_add_alt),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Add Customer"),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateCustomer()));
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.report_problem_sharp),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text("Report"),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReportPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}