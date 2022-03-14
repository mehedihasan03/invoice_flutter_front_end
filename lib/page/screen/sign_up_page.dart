import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_flutter/helper/http_helper.dart';
import 'package:invoice_flutter/helper/my_host_api.dart';
import 'package:invoice_flutter/page/model/user.dart';
import 'package:invoice_flutter/utils/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Resistration"),
          elevation: .1,
          backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Registration Form',
                        style: TextStyle(
                            color: Color.fromRGBO(49, 87, 110, 1.0),
                            fontWeight: FontWeight.w900,
                            fontSize: 40),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 25.0, right: 20.0, bottom: 0.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.person),
                        hintText: 'Enter your full name',
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 4.0, right: 20.0, bottom: 0.0),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.verified_user),
                        hintText: 'Enter a Username',
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter unique Username';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 4.0, right: 20.0, bottom: 4.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.email),
                        hintText: 'Enter your email address',
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 4.0, right: 20.0, bottom: 4.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.password),
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter correct password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 4.0, right: 20.0, bottom: 4.0),
                    child: TextFormField(
                      controller: _repasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.password),
                        hintText: 'Re-Type Your Password',
                        labelText: 'Re-Type Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Re-Type Your Password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(49, 87, 110, 1.0)
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        saveUser();
                      },
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('Already have an account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.loginRoute);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> sendEmail() async {
    String email = _emailController.value.text;

    Map _data = {'receiver': jsonEncode(email)};
    //encode Map to JSON
    String _body = json.encode(_data);

    try {
      final response = await _http.postData(host + '/sendUserEmail', _body);
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

  Future<void> saveUser() async {
    String name = _nameController.value.text;
    String username = _usernameController.value.text;
    String email = _emailController.value.text;
    String pass = _passwordController.value.text;
    String repass = _repasswordController.value.text;

    if (pass == repass) {
      String password = pass;
      var model = User(
          name: name, username: username, email: email, password: password);

      String _body = jsonEncode(model.toMap());

      try {
        final response = await _http.postData(host + '/user/save', _body);
        sendEmail();
        Fluttertoast.showToast(
            msg: "User Created Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            fontSize: 20,
            backgroundColor: Colors.green);
        _nameController.clear();
        _usernameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _repasswordController.clear();
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
}
