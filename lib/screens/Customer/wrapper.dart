import 'package:ajeeb/models/user.dart';
import 'package:ajeeb/authenticate/authenticateCustomer.dart';
import 'package:ajeeb/screens/Customer/homeCust.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomeCust();
    }

  }
}