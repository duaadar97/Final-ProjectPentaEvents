import 'package:ajeeb/screens/Customer/wrapper.dart';
import 'package:ajeeb/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ajeeb/models/user.dart';

//import 'file:///C:/Users/kinza/Desktop/-new Final/-new/lib/screens/Customer/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}