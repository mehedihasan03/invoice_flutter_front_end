import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_flutter/helper/my_host_api.dart';
import 'package:invoice_flutter/page/model/login.dart';
import 'package:invoice_flutter/utils/routes.dart';

import '../helper/http_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _http = HttpHelper();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginUser() async {
    String username = _usernameController.value.text;
    String password = _passwordController.value.text;

    var model = Login(username: username, password: password);

    String _body = jsonEncode(model.toMap());

    try {
      final response =
          await _http.postData(host+'/login', _body);
      print(response.toString());

        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Dashboard()));
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HomePage()));
      Navigator.pushNamed(context, MyRoutes.homeRoute);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Login"
        ),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'User Login',
                    style: TextStyle(
                        color: Color.fromRGBO(49, 87, 110, 1.0),
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  )
              ),

              Container(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: "Type your username"
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: "Type your password"
                  ),
                ),
              ),
              const SizedBox(height: 50.0,),
              TextButton(
                onPressed: () {
//forgot password screen
                },
                child: const Text('Forgot Password?',),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                    onPressed: () {
                      print(_usernameController.text);
                      print(_passwordController.text);
                      loginUser();
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.signupRoute);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )
      ),
    );
  }



}



