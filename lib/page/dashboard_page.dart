import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(5.0),
              children: <Widget>[
                makeDashboardItem("Total Invoice", Icons.receipt),
                makeDashboardItem("Today Invoice", Icons.receipt),
                makeDashboardItem("Monthly Sale", Icons.attach_money),
                makeDashboardItem("Daily Sale", Icons.attach_money)
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          Expanded(
            child: ListView(children: <Widget>[
              Center(
                  child: Text(
                'Invoices',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              Center(
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text('ID',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Name',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Account Name',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Amount',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('Actor')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('Actor')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('5')),
                      DataCell(Text('John')),
                      DataCell(Text('Student')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('Actor')),
                    ])
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

Card makeDashboardItem(String title, IconData icon) {
  return Card(
    elevation: 20.0,
    shadowColor: Colors.orange,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    margin: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(255, 142, 0, 1.0)),
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
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            )
          ],
        ),
      ),
    ),
  );
}
