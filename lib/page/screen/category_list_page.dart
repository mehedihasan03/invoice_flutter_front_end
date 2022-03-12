import 'dart:convert';

import 'package:flutter/material.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';
import '../model/category.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _nameController = TextEditingController();
  final _http = HttpHelper();
  List<Category> categories = [];

  @override
  void initState() {
    getCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(children: <Widget>[
            Center(
                child: Text(
              'Total Categories',
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
                        getCategoriesData();
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
                              label: Text('Category Name',
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
                          for (int i = 0; i < categories.length; i++)
                            DataRow(cells: [
                              DataCell(Text(
                                categories[i].cid.toString(),
                                textAlign: TextAlign.center,
                              )),
                              DataCell(Text(
                                categories[i].cname,
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

  Future<void> getCategoriesData() async {
    final res = await _http.getData(host + "/category/getAll");
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Customer list console printed");
      setState(() {
        categories = data.map((data) => Category.fromMap(data)).toList();
      });
    }
  }

  Future<void> getSearchData() async {
    String searchText = _nameController.value.text;
    final res =
        await _http.getData(host + "/category/search?searchText=" + searchText);
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);
      var data = map['Data'] as List<dynamic>;
      print("Category search console printed");
      setState(() {
        categories = data.map((e) => Category.fromMap(e)).toList();
      });
    }
  }
}
