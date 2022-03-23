import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/model/customer.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';
import '../model/Product.dart';

class CreateInviocePage extends StatefulWidget {
  const CreateInviocePage({Key? key}) : super(key: key);

  @override
  _CreateInviocePageState createState() => _CreateInviocePageState();
}

class _CreateInviocePageState extends State<CreateInviocePage> {
  late Customer invoiceCustomer;
  late Product invoiceProduct;
  List<Product> products = [];
  bool selected = false;
  final _dateController = TextEditingController();
  @override
  void initState() {
    getProductData();
    super.initState();
  }

  Future<void> getProductData() async {
    final _http = HttpHelper();

    final res = await _http.getData(host + "/product/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;

      print("Product list printed");
      setState(() {
        products = data.map((e) => Product.fromMap(e)).toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                                flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Select date here',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                              "Invoice No: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: ""
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: EdgeInsets.all(10),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.zero,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 15, bottom: 10),
                                child: Text(
                                  'NCLC JEE-47',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Email: nclc.round47@gmail.com',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Phone: (555) 539-1037',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Momtaz Plaza, Dhanmondi-4',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Dhanmondi, Dhaka-1205',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black12),
                                ),
                                onPressed: () {
                                  showCustomerAlertDialog(context);
                                },
                                child: Text(
                                  'Add Customer',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        invoiceCustomer.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Email: " + invoiceCustomer.email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Phone: " + invoiceCustomer.phone,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              if (selected)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "Address: " + invoiceCustomer.address,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(
                                Colors.black),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                Colors.black12),
                          ),
                          onPressed: () {
                            showProductAlertDialog(context);
                          },
                          child: Text(
                            'Add Products',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  showCustomerAlertDialog(BuildContext context) {
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
  showProductAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Widget alert = MyProductAlert();

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      setState(() {
        invoiceProduct = value;
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


class MyProductAlert extends StatefulWidget {
  const MyProductAlert({Key? key}) : super(key: key);

  @override
  State<MyProductAlert> createState() => _MyProductAlertState();
}



class _MyProductAlertState extends State<MyProductAlert> {
  List<Product> products = [];
  final _nameController = TextEditingController();
  final _http = HttpHelper();

  @override
  void initState() {
    getProductData();
  }

  Future<void> getProductData() async {
    final _http = HttpHelper();

    final res = await _http.getData(host + "/product/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;

      print("Product list Dialogue box printed");
      setState(() {
        products = data.map((e) => Product.fromMap(e)).toList();
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("Products"),
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
                      getProductData();
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
                        label: Text('Category',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    DataColumn(
                        label: Text('Price',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                  ],
                  rows: [
                    for (int i = products.length - 1; i >= 0; i--)
                      DataRow(
                          onSelectChanged: (isSelected) {
                            Navigator.of(context).pop(products[i]);
                            setState(() {});
                          },
                          cells: [
                            DataCell(Text(
                              products[i].pid.toString(),
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(
                              products[i].pname,
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(
                              products[i].cname,
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(
                              products[i].price.toString(),
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
    await _http.getData(host + "/product/search?searchText=" + searchText);
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Product search console printed");
      setState(() {
        products = data.map((e) => Product.fromMap(e)).toList();
      });
    }
  }
}
