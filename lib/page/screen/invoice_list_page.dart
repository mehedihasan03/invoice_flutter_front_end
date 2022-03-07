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
                cursorColor: Color.fromRGBO(49, 87, 110, 1.0),
                decoration: InputDecoration(
                    fillColor: Color.fromRGBO(49, 87, 110, 1.0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(49, 87, 110, 1.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Color.fromRGBO(49, 87, 110, 1.0),
                      ),
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
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Payment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Amount',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Action',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ],
                        rows: [
                          for (int i = 0; i < invoices.length; i++)
                            DataRow(cells: [
                              DataCell(Text(invoices[i].id.toString(), textAlign: TextAlign.center,)),
                              DataCell(Text(invoices[i].customerName, textAlign: TextAlign.center,)),
                              DataCell(Text(invoices[i].paymentDate, textAlign: TextAlign.center,)),
                              DataCell(Text(invoices[i].accountNumber, textAlign: TextAlign.center,)),
                              DataCell(Text(invoices[i].totalPrice.toString(), textAlign: TextAlign.center,)),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit_outlined),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
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
