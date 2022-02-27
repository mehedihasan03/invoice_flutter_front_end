import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/create_invoice_page.dart';
import 'package:invoice_flutter/page/invoice_list_page.dart';
import 'package:invoice_flutter/page/model/invoice.dart';

import '../helper/http_helper.dart';
import 'model/totalInvoiceCount.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _http = new HttpHelper();
  var totalInvoice;
  var todayInvoices;
  var monthlySale;
  var dailySale;
  List<Invoice> invoices = [];

  @override
  void initState() {
    getTotalInvoice();
    getTodayInvoices();
    getMonthlySale();
    getDailySale();
    getInvoiceData();
    super.initState();
  }

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
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                makeDashboardItem(
                    "Total Invoice ", Icons.receipt, totalInvoice),
                makeDashboardItem(
                    "Today Invoice", Icons.receipt, todayInvoices),
                makeDashboardItem(
                    "Monthly Sale", Icons.attach_money, monthlySale),
                makeDashboardItem(
                    "Daily Sale", Icons.attach_money, dailySale)
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: Container(
              child: ListView(children: <Widget>[
                Center(
                    child: Text(
                  'Invoices',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                Center(
                  child: Flexible(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('ID',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Name',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Date',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Account Name',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Amount',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))),
                      ],
                      rows: [
                        for(int i = 0; i < invoices.length; i++)
                        DataRow(cells: [
                          DataCell(Text(invoices[i].id.toString())),
                          DataCell(Text(invoices[i].customerName)),
                          DataCell(Text(invoices[i].paymentDate)),
                          DataCell(Text(invoices[i].accountNumber)),
                          DataCell(Text(invoices[i].totalPrice.toString())),
                        ])
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getTotalInvoice() async {
    final res =
        await _http.getData("http://192.168.1.85:9988/invoice/count-invoice");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      print(map['Data']);
      print("Total invoice console printed");
      setState(() {
        totalInvoice = map['Data'];
      });
    }
  }

  Future<void> getTodayInvoices() async {
    final res =
        await _http.getData("http://192.168.1.85:9988/invoice/count-today-invoices");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      print(map['Data']);
      print("Today Invoice console printed");
      setState(() {
        todayInvoices = map['Data'];
      });
    }
  }

  Future<void> getMonthlySale() async {
    final res =
        await _http.getData("http://192.168.1.85:9988/invoice/current-sale");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      print(map['Data']);
      print("Monthly Sale console printed");
      setState(() {
        monthlySale = map['Data'];
      });
    }
  }

  Future<void> getDailySale() async {
    final res =
        await _http.getData("http://192.168.1.85:9988/invoice/count-daily-sale");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      print(map['Data']);
      print("Daily Sale console printed");
      setState(() {
        dailySale = map['Data'];
      });
    }
  }

  Future<void> getInvoiceData() async {
    final res =
        await _http.getData("http://192.168.1.85:9988/invoice/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
var data = map['Data'] as List<dynamic>;
      print("Invoice list console printed");
      setState(() {
        invoices = data.map((e) => Invoice.fromMap(e)).toList();

      });
    }
  }
}

Card makeDashboardItem(String title, IconData icon, count) {
  return Card(
    elevation: 20.0,
    shadowColor: Colors.black45,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    margin: const EdgeInsets.all(20.0),
    child: Container(
      decoration:
          const BoxDecoration(color: Color.fromRGBO(0, 72, 255, 1.0)),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            const SizedBox(height: 40.0),
            Center(
                child: Icon(
              icon,
              size: 60.0,
              color: Colors.black,
            )),
            const SizedBox(height: 15.0),
            Center(
              child: Text(title,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: Text(count.toString(),
                  style: const TextStyle(fontSize: 34.0, fontWeight: FontWeight.w700, color: Colors.black)),
            )
          ],
        ),
      ),
    ),
  );
}
