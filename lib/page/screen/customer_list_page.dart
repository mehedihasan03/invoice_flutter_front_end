import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_flutter/page/model/customer.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _nameController = TextEditingController();
  final _http = HttpHelper();
  List<Customer> customers = [];

  @override
  void initState() {
    getCustomersData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(children: <Widget>[
            Center(
                child: Text(
              'Total Products',
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
                        getCustomersData();
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
                              label: Text("Email",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Contact',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Address',
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
                          for (int i = 0; i < customers.length; i++)
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
                              DataCell(Text(
                                customers[i].phone,
                                textAlign: TextAlign.center,
                              )),
                              DataCell(Text(
                                customers[i].address,
                                textAlign: TextAlign.center,
                              )),
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

  Future<void> getCustomersData() async {
    final res = await _http.getData(host + "/customer/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Customer list console printed");
      setState(() {
        customers = data.map((data) => Customer.fromMap(data)).toList();
      });
    }
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
