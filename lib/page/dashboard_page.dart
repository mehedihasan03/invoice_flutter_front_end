import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_flutter/helper/my_host_api.dart';
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
    return Column(
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
              makeDashboardItem("Daily Sale", Icons.attach_money, dailySale)
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: ListView(children: <Widget>[
            Center(
                child: Text(
              'Invoices',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Color.fromRGBO(49, 87, 110, 1.0)),
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color.fromRGBO(49, 87, 110, 1.0)),
                  columns: [
                    DataColumn(
                        label: Text('ID',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Name',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Account Name',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Amount',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    for (int i = 0; i < invoices.length; i++)
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
            )
          ]),
        ),
      ],
    );
  }

  Future<void> getTotalInvoice() async {
    final res = await _http.getData(host + "/invoice/count-invoice");
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
    final res = await _http.getData(host + "/invoice/count-today-invoices");
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
    final res = await _http.getData(host + "/invoice/current-sale");
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
    final res = await _http.getData(host + "/invoice/count-daily-sale");
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
    final res = await _http.getData(host + "/invoice/getAll");
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
    shadowColor: Colors.black87,
    margin: EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.white60),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 20.0),
              Center(
                  child: Icon(
                icon,
                size: 40.0,
                color: Colors.black,
              )),
              SizedBox(height: 15.0),
              Center(
                child: Text(title,
                    style: TextStyle(fontSize: 20.0, color: Colors.black)),
              ),
              SizedBox(height: 15.0),
              Center(
                child: Text(count.toString(),
                    style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
