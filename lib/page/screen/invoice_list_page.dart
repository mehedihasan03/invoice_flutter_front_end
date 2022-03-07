import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';
import '../model/invoice.dart';

class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({Key? key}) : super(key: key);

  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  final _nameController = TextEditingController();

  final _http = HttpHelper();
  List<Invoice> invoices = [];

  @override
  void initState() {
    getInvoiceData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: ListView(children: <Widget>[
            Center(
                child: Text(
              'Total Invoices',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    fillColor: Color.fromRGBO(49, 87, 110, 1.0),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _nameController.clear();
                        getInvoiceData();
                      },
                    ),
                    suffix: RaisedButton(
                      color: Color.fromRGBO(49, 87, 110, 1.0),
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        getSearchData();
                      },
                    ),
                    hintText: 'Search here',
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Color.fromRGBO(49, 87, 110, 1.0)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Color.fromRGBO(49, 87, 110, 1.0)),
                        columns: [
                          DataColumn(
                              label: Text('ID',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Name',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Date',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Payment',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Amount',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold))),
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
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
    );
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

  Future<void> getSearchData() async {
    String searchText = _nameController.value.text;
    final res =
        await _http.getData(host + "/invoice/search?searchText=" + searchText);
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Invoice search console printed");
      setState(() {
        invoices = data.map((e) => Invoice.fromMap(e)).toList();
      });
    }
  }
}
