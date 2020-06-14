
import 'package:ajeeb/screens/CustEvent.dart';
import 'package:flutter/material.dart';
import 'dart:async';
void main() => runApp(MySplash());

class MySplash extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Splash",
      home: SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void completed(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CustEvent();
    }));
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds :5),completed);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              //color: Colors.amber,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background15.jpg')),
            ),
            child:Center(

              child: Image.asset('assets/appIcon.jpg'),

            )
        )
    );
  }

}