 import 'dart:io';

// import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

 void main() => runApp(Contact());

 class Contact extends StatelessWidget {
   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,

       theme: ThemeData(
         primarySwatch: Colors.teal,
       ),
       home: Scaffold(appBar: AppBar(title: Text('Contact Us'),
           backgroundColor: Colors.teal,
           leading:IconButton(
             onPressed: (){
               Navigator.of(context).pop();
             },
             icon: Icon(Icons.arrow_back),
           )
       ),
       body:
       Container (
           decoration: new BoxDecoration(
             image: DecorationImage(
                 fit: BoxFit.cover,
                 image: AssetImage('assets/background15.jpg')),
           ),
//         alignment:Alignment.topLeft,
//           margin: EdgeInsets.only(left:10,right:10),
         //margin: EdgeInsets.all(4.0),
         child:
         Column(
           children: <Widget>[
             Container(
               alignment:Alignment.center,
               margin: EdgeInsets.only(top:270.0),
                child:Text('Contact us through email:',
                style:TextStyle(
                fontSize: 15.0,
         )),
             ),
                GestureDetector(
                  onTap: (){
                    print("i was tapped");
                     _launchURL('pentaevents123@gmail.com', '', '');
                      
                  },
                  child: Container(

                    alignment:Alignment.center,
                    margin: EdgeInsets.only(top:25.0),
                    child:Center(
                      child:Text('pentaevents123@gmail.com',
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,fontStyle: FontStyle.italic,
                      ),)
                    )
                  ),
                )
         ],)
       )


         ),
      );


   }
 
  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //     body: new Center(
  //       child: new RaisedButton(onPressed: () => _launchURL('vinoth1094@gmail.com', 'Flutter Email Test', 'Hello Flutter'), child: new Text('Send mail'),),
  //     ),
  //   );
  // }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

 
 }