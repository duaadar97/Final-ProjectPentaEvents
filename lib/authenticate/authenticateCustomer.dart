//import 'package:pentaevents/screens/authenticate/register_as_event_manager.dart';
import 'package:ajeeb/authenticate/register_as_customer.dart';
import 'package:ajeeb/authenticate/signIn.dart';
import 'package:flutter/material.dart';

//void main() {
//
//  runApp(MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: Authenticate()));
//}



class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView1(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView1:  toggleView1);
    } else {
      return  RegisterAsCustomer(toggleView1:  toggleView1);
    }
  }
}