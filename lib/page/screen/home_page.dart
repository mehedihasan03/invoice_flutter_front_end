import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/screen/about_page.dart';
import 'package:invoice_flutter/page/screen/category_list_page.dart';
import 'package:invoice_flutter/page/screen/create_category_page.dart';
import 'package:invoice_flutter/page/screen/create_customer_page.dart';
import 'package:invoice_flutter/page/screen/customer_list_page.dart';
import 'package:invoice_flutter/page/screen/invoice_list_page.dart';
import 'package:invoice_flutter/page/screen/product_list_page.dart';
import 'package:invoice_flutter/page/screen/profile_page.dart';
import 'package:invoice_flutter/page/screen/report_page.dart';
import 'package:invoice_flutter/page/screen/searh_page.dart';

import 'bottom_navigation_page.dart';
import 'create_invoice_page.dart';
import 'create_product.dart';
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
    CustomersPage(),
    CategoriesPage(),
    ProductsPage(),
    NewCategoryPage()
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
    } else if (currentPage == DrawerSections.categories) {
      container = CategoriesPage();
    } else if (currentPage == DrawerSections.customers) {
      container = CustomersPage();
    } else if (currentPage == DrawerSections.products) {
      container = ProductsPage();
    } else if (currentPage == DrawerSections.createCategory) {
      container = NewCategoryPage();
    } else if (currentPage == DrawerSections.createProduct) {
      container = CreateProductPage();
    }

    return Scaffold(
      floatingActionButton: showFloatingButton()
          ? FloatingActionButton(
              onPressed: () {
                if (currentPage == DrawerSections.invoiceList)
                  currentPage = DrawerSections.createInvoice;
                if (currentPage == DrawerSections.customers)
                  currentPage = DrawerSections.createCustomer;
                if (currentPage == DrawerSections.categories)
                  currentPage = DrawerSections.createCategory;
                if (currentPage == DrawerSections.products)
                  currentPage = DrawerSections.createProduct;
                setState(() {});
              },
              hoverColor: Colors.green,
              foregroundColor: Colors.white,
              highlightElevation: 50,
              child: Icon(
                Icons.add,
                size: 50.0,
              ),
              backgroundColor:
                  Color.fromRGBO(49, 87, 110, 1.0).withOpacity(0.6),
            )
          : null,
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

  bool showFloatingButton() {
    return currentPage == DrawerSections.invoiceList ||
        currentPage == DrawerSections.products ||
        currentPage == DrawerSections.categories ||
        currentPage == DrawerSections.customers;
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
          Divider(
            thickness: 2,
          ),
          menuItem(2, "Invoices", Icons.event,
              currentPage == DrawerSections.invoiceList ? true : false),
          menuItem(3, "Products", Icons.poll_rounded,
              currentPage == DrawerSections.products ? true : false),
          menuItem(4, "Categories", Icons.category_outlined,
              currentPage == DrawerSections.categories ? true : false),
          menuItem(5, "Customers", Icons.person,
              currentPage == DrawerSections.customers ? true : false),
          Divider(
            thickness: 2,
          ),
          menuItem(6, "New Invoice", Icons.add_shopping_cart,
              currentPage == DrawerSections.createInvoice ? true : false),
          menuItem(7, "New Product", Icons.playlist_add_rounded,
              currentPage == DrawerSections.createProduct ? true : false),
          menuItem(8, "New Category", Icons.category_outlined,
              currentPage == DrawerSections.createCategory ? true : false),
          menuItem(9, "New Customer", Icons.person_add_alt_1_rounded,
              currentPage == DrawerSections.createCustomer ? true : false),
          Divider(
            thickness: 2,
          ),
          menuItem(10, "Profile", Icons.person_pin_outlined,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(11, "About", Icons.web,
              currentPage == DrawerSections.about ? true : false),
          Divider(
            thickness: 2,
          ),
          menuItem(12, "Report", Icons.report_problem_outlined,
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
              currentPage = DrawerSections.products;
            } else if (id == 4) {
              currentPage = DrawerSections.categories;
            } else if (id == 5) {
              currentPage = DrawerSections.customers;
            } else if (id == 6) {
              currentPage = DrawerSections.createInvoice;
            } else if (id == 7) {
              currentPage = DrawerSections.createProduct;
            } else if (id == 8) {
              currentPage = DrawerSections.createCategory;
            } else if (id == 9) {
              currentPage = DrawerSections.createCustomer;
            } else if (id == 10) {
              currentPage = DrawerSections.profile;
            } else if (id == 11) {
              currentPage = DrawerSections.about;
            } else if (id == 12) {
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
  customers,
  products,
  categories,
  invoiceList,
  profile,
  createCustomer,
  createCategory,
  createProduct,
  report,
  about,
}
