 import 'package:flutter/material.dart';

 void main() => runApp(About());

 class About extends StatelessWidget {
   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,

       theme: ThemeData(
         primarySwatch: Colors.teal,
       ),
       home: Scaffold(appBar: AppBar(title: Text('About Us'),
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
         alignment:Alignment.topLeft,
         child:Container(
         margin: EdgeInsets.only(right:10.0 , left:10.0,top: 20.0),
           child: Text('Hey Users! We warmly welcome you to our application.'
               'If you are worried about organizing your events with perfection '
               'and on the right time,then CONGRATULATIONS! You have knocked the right door.'
               ' We will provide you a fully organized platform where you can contact multiple event organizers,'
               'can visit their profiles and book your event from your desired event orgainzer. '
               'You now have no need to waste your event travelling cost in visiting the event management companies '
               'physically or wasting your precious time in surfing multiple sites over the internet.'
               'Our application is solution to all your problems!',
             style: TextStyle
               (
               fontSize: 17.0,
               letterSpacing: 1.0,
               fontStyle: FontStyle.italic,
             ),
             textAlign: TextAlign.left,

           ),
         ),
       ),
      ),

     );
   }
 }