import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_flutter/page/model/add_product.dart';

import '../../helper/http_helper.dart';
import '../../helper/my_host_api.dart';
import '../model/category.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _http = HttpHelper();
  List<Category> categories = [];
  String dropdownValue = 'Select One';

  final _productNameController = TextEditingController();
  final _categoryNameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: const Text(
                'Add new Product',
                style: TextStyle(
                    color: Color.fromRGBO(49, 87, 110, 1.0),
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: TextField(
              controller: _productNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Name',
                  hintText: "Product Name"),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                elevation: 16,
                style: TextStyle(color: Color.fromRGBO(49, 87, 110, 1.0)),
                underline: Container(
                  height: 2,
                  color: Color.fromRGBO(49, 87, 110, 1.0),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Select One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
            child: TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                  hintText: "Price"),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(49, 87, 110, 1.0)),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  print(_productNameController.text);
                  print(_categoryNameController.text);
                  print(_priceController.text);
                  addProduct();
                },
              )),
        ],
      ),
    );
  }

  Future<void> addProduct() async {
    String productName = _productNameController.value.text;
    String categoryName = _categoryNameController.value.text;
    double price = double.parse(_priceController.value.text);

    var model =
        AddProduct(pname: productName, cname: categoryName, price: price);
    String _body = jsonEncode(model.toMap());

    try {
      final response = await _http.postData(host + '/product/save', _body);
      Fluttertoast.showToast(
          msg: "New Product added Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          fontSize: 20,
          backgroundColor: Colors.green);
      _productNameController.clear();
      _categoryNameController.clear();
      _priceController.clear();
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
}
