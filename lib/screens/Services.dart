import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Services extends StatefulWidget {
  String data;
  Services(this.data);
  @override
  _MyCategoryState createState() => _MyCategoryState(data);
}

class _MyCategoryState extends State<Services> {
  var listdata = [];
    String data;
  _MyCategoryState(this.data);
@override
 void didChangeDependencies(){
  super.didChangeDependencies();
    print("print d");
   

    fetchFromFirebase();

 }

fetchFromFirebase (){
  print("this is a msgsss");
    Firestore.instance.collection("Event_manager")
    .document(this.data).get()
    .then( (snapshot) {
      print("printing datai in cat ");
      // List<String>.from(snapshot["Event_categories"]).fromMap(Map<String, dynamic> data) {
      //       catlist = data['Event_categories'].cast<String>();
      //   }
      // for(int i =0;i<snapshot["Event_categories"].length;i++){
      //   listdata.add( snapshot["Event_categories"][i]);
      // }
      // for(int i =0;i<snapshot["Event_themes"].length;i++){
      //   listdata.add( snapshot["Event_themes"][i]);
      // }
      for(int i =0;i<snapshot["Event_services"].length;i++){
        listdata.add( snapshot["Event_services"][i]);
      }

        //  catlist  = parsed;
      this.setState(() {
                   });
      print(listdata);
      
    } );
}
 

  @override
  Widget build(BuildContext context) {
    final title = 'Services';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          title: Text(title),
          leading:IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          decoration: new BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/des.jpg')),
          ),
        child: ListView(
          children: listdata.map((document) {
            return new ListTile(
              title: new Text(document),
             
            );
          }).toList(),
        ),
      ),
      )
    );
  }

}



