import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(5.0),
          children: <Widget>[
            makeDashboardItem("Total Invoice", Icons.receipt),
            makeDashboardItem("Today Invoice", Icons.receipt),
            makeDashboardItem("Monthly Sale", Icons.attach_money),
            makeDashboardItem("Daily Sale", Icons.attach_money)
          ],
        ),
      ),
    );
  }
}
Card makeDashboardItem(String title, IconData icon) {
  return Card(
      elevation: 1.0,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(49, 87, 110, 1.0)),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              const SizedBox(height: 20.0),
              Center(
                  child: Icon(
                    icon,
                    size: 40.0,
                    color: Colors.black,
                  )),
              const SizedBox(height: 10.0),
              Center(
                child: Text(title,
                    style:
                    const TextStyle(fontSize: 20.0, color: Colors.black)),
              )
            ],
          ),
        ),
      ),
  );

}