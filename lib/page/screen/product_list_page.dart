import 'dart:convert';

import 'package:flutter/material.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';
import '../model/Product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _nameController = TextEditingController();
  final _http = HttpHelper();
  List<Product> products = [];

  @override
  void initState() {
    getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(children: <Widget>[
            Center(
                child: Text(
              'All Products',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
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
                        getProductsData();
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
                              label: Text('P.Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('C.Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          DataColumn(
                              label: Text('Price',
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
                          for (int i = 0; i < products.length; i++)
                            DataRow(cells: [
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

  Future<void> getProductsData() async {
    final res = await _http.getData(host + "/product/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Product list console printed");
      setState(() {
        products = data.map((data) => Product.fromMap(data)).toList();
      });
    }
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
