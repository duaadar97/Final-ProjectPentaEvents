import 'package:ajeeb/authenticate/register_as_event_manager.dart';
import 'package:ajeeb/authenticate/signInEvent.dart';
import 'package:flutter/material.dart';


//void main() {
//
//  runApp(MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: AuthenticateEventManager()));
//}


class AuthenticateEventManager extends StatefulWidget {
  @override
  _AuthenticateEventManagerState createState() => _AuthenticateEventManagerState();
}

class _AuthenticateEventManagerState extends State<AuthenticateEventManager> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInEvent(toggleView:  toggleView);
    } else {
      return  RegisterAsEventManager(toggleView:  toggleView);
    }
  }
}