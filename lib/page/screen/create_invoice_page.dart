import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/model/customer.dart';
import 'package:invoice_flutter/page/screen/home_page.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';

class CreateInviocePage extends StatefulWidget {
  const CreateInviocePage({Key? key}) : super(key: key);

  @override
  _CreateInviocePageState createState() => _CreateInviocePageState();
}

class _CreateInviocePageState extends State<CreateInviocePage> {
  late Customer invoiceCustomer;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [

            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text('Heed not the rabble'),
                    color: Colors.white70,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(Colors.black),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.black12),
                                ),
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                child: Text(
                                    'Add Customer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                  ),
                                ),
                              ),

                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                          invoiceCustomer.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Email: " + invoiceCustomer.email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Phone: " + invoiceCustomer.phone,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Address: " + invoiceCustomer.address,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Widget alert = MyAlert();

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      setState(() {
        invoiceCustomer = value;
        selected = true;
      });
    });
  }
}

class MyAlert extends StatefulWidget {
  const MyAlert({Key? key}) : super(key: key);

  @override
  State<MyAlert> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  List<Customer> customers = [];
  final _nameController = TextEditingController();
  final _http = HttpHelper();

  @override
  void initState() {
    getCustomerData();
  }

  Future<void> getCustomerData() async {
    final _http = HttpHelper();

    final res = await _http.getData(host + "/customer/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;

      print("Customer list Dialogue box printed");
      setState(() {
        customers = data.map((e) => Customer.fromMap(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("Customers"),
      ),
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
                      getCustomerData();
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DataTable(
                  showCheckboxColumn: false,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color.fromRGBO(49, 87, 110, 1.0)),
                  columns: [
                    DataColumn(
                        label: Text('ID',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    DataColumn(
                        label: Text('Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    DataColumn(
                        label: Text('Email',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    DataColumn(
                        label: Text('Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                  ],
                  rows: [
                    for (int i = customers.length - 1; i >= 0; i--)
                      DataRow(
                          onSelectChanged: (isSelected) {
                            Navigator.of(context).pop(customers[i]);
                            setState(() {});
                          },
                          cells: [
                            DataCell(Text(
                              customers[i].id.toString(),
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(
                              customers[i].name,
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(
                              customers[i].email,
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(
                              customers[i].address,
                              textAlign: TextAlign.center,
                            )),
                          ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Add"),
          onPressed: () {
            Navigator.of(context).pop("mehedi");
          },
        ),
      ],
    );
  }

  Future<void> getSearchData() async {
    String searchText = _nameController.value.text;
    final res =
        await _http.getData(host + "/customer/search?searchText=" + searchText);
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Customer search console printed");
      setState(() {
        customers = data.map((e) => Customer.fromMap(e)).toList();
      });
    }
  }
}
