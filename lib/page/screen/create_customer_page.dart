import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_flutter/helper/http_helper.dart';
import 'package:invoice_flutter/helper/my_host_api.dart';
import 'package:invoice_flutter/page/model/add_customer.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({Key? key}) : super(key: key);

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  final _http = HttpHelper();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

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
                    'Add new Customer',
                    style: TextStyle(
                        color: Color.fromRGBO(49, 87, 110, 1.0),
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Fullname',
                      hintText: "Type your Fullname"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: "Type your Email ID"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: TextField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact',
                      hintText: "Type your Phone number"),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: "Type your Address"),
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
                        primary: Color.fromRGBO(49, 87, 110, 1.0)
                    ),
                    child: const Text(
                      'Add',
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {
                      print(_nameController.text);
                      print(_emailController.text);
                      print(_mobileController.text);
                      print(_addressController.text);
                      addCustomer();
                    },
                  )),
            ],
          ),
    );
  }

  Future<void> addCustomer() async {
    String name = _nameController.value.text;
    String email = _emailController.value.text;
    String mobile = _mobileController.value.text;
    String address = _addressController.value.text;

    var model =
        AddCustomer(name: name, email: email, phone: mobile, address: address);
    String _body = jsonEncode(model.toMap());

    try {
      final response = await _http.postData(host + '/customer/save', _body);
      sendEmail();
      Fluttertoast.showToast(
          msg: "New Customer added Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          fontSize: 20,
          backgroundColor: Colors.green);
      _nameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _addressController.clear();
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

  Future<void> sendEmail() async {

    String email = _emailController.value.text;

    Map _data = {'receiver': jsonEncode(email)};
    //encode Map to JSON
    String _body = json.encode(_data);

    try {
      final response = await _http.postData(host + '/sendCustomerEmail', _body);
      Fluttertoast.showToast(
          msg: "Email send successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          fontSize: 20,
          backgroundColor: Colors.green);
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
}
