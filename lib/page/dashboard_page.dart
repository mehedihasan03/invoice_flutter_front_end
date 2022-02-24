import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/create_invoice_page.dart';
import 'package:invoice_flutter/page/invoice_list_page.dart';

import '../helper/http_helper.dart';
import 'model/totalInvoiceCount.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _http = new HttpHelper();
  var totalInvoiceCount;

  getInvoiceCount() async {
    final res = await _http.getData("http://192.168.0.104:9988/invoice/count-invoice");
    if (res.statusCode == 200) {
      totalInvoiceCount = jsonEncode(res.body);
      print(totalInvoiceCount);
      print("console printed");
      setState(() {
        this.totalInvoiceCount;
      });
    }
  }

  @override
  void initState() {
    getInvoiceCount();
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
                makeDashboardItem("Total Invoice", Icons.receipt),
                makeDashboardItem("Today Invoice", Icons.receipt),
                makeDashboardItem("Monthly Sale", Icons.attach_money),
                makeDashboardItem("Daily Sale", Icons.attach_money)
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
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
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(Text('Stephen')),
                        DataCell(Text('Actor')),
                        DataCell(Text('Stephen')),
                        DataCell(Text('Actor')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('John')),
                        DataCell(Text('Student')),
                        DataCell(Text('Stephen')),
                        DataCell(Text('Actor')),
                      ])
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

Card makeDashboardItem(String title, IconData icon) {
  return Card(
    elevation: 20.0,
    shadowColor: Colors.orange,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    margin: const EdgeInsets.all(8.0),
    child: Container(
      decoration:
          const BoxDecoration(color: Color.fromRGBO(116, 255, 226, 1.0)),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Center(
                child: Icon(
              icon,
              size: 40.0,
              color: Colors.black,
            )),
            const SizedBox(height: 15.0),
            Center(
              child: Text(title,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            ),
            const SizedBox(height: 15.0),
            Center(
              child: Text(title,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            )
          ],
        ),
      ),
    ),
  );
}
