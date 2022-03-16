import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,
                        color: Color.fromRGBO(49, 87, 110, 1.0)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Color.fromRGBO(49, 87, 110, 1.0),
                      ),
                      onPressed: () {
                        /* Clear the search field */
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}
