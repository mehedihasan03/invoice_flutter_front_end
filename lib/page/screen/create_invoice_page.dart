import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/model/customer.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';

class CreateInviocePage extends StatefulWidget {
  const CreateInviocePage({Key? key}) : super(key: key);

  @override
  _CreateInviocePageState createState() => _CreateInviocePageState();
}

class _CreateInviocePageState extends State<CreateInviocePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black12),
                ),
                onPressed: () {
                  showAlertDialog(context);
                },
                child: Text('Add Customer'),
                
              ),
            ],
          ),
          color: Colors.white70,
        ),
      ],
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
    );
  }
}

class MyAlert extends StatefulWidget {
  const MyAlert({Key? key}) : super(key: key);

  @override
  State<MyAlert> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  List<Customer> customers = [];


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

      print("Customer list console printed");
      setState(() {
        customers = data.map((e) => Customer.fromMap(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Customers")),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromRGBO(49, 87, 110, 1.0)),
              columns: [
                DataColumn(
                    label: Text('ID',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text('Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text('Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
              ],
              rows: [
                for (int i = customers.length - 1; i >= 0; i--)
                  DataRow(cells: [
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
                  ]),
              ],
            ),
          ],
        ),
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

}
