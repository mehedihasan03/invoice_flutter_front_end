import 'package:flutter/cupertino.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({Key? key}) : super(key: key);

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text("Customer Creation Page")
      )
    );
  }
}
