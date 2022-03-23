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
   String selectedCategory = 'Select Category';
  List<String> list = ['Select Category'];
  final _productNameController = TextEditingController();

  final _priceController = TextEditingController();
@override
  void initState() {
   getCategoriesData();
    super.initState();
  }
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
            padding: EdgeInsets.only(left: 30, right: 30, top: 20,bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButton<String>(
              value: selectedCategory,
              icon: Icon(Icons.arrow_drop_down_sharp,
              ),
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: list
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
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
            height: 50.0,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(49, 87, 110, 1.0)),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  print(_productNameController.text);
                  print(selectedCategory);
                  print(_priceController.text);
                  if(selectedCategory != 'Select Category'){
                    addProduct();
                  } else{
                    Fluttertoast.showToast(
                        msg: "Please Select Category",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        fontSize: 20,
                        backgroundColor: Colors.red);
                  }
                },
              )),
        ],
      ),
    );
  }

  Future<void> addProduct() async {
    String productName = _productNameController.value.text;
    String categoryName = selectedCategory;
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

      categories = data.map((data) => Category.fromMap(data)).toList();
           list.addAll(categories.map((e) => e.cname).toList());
      print(list);
      setState(() {

      });
    }
  }
}
