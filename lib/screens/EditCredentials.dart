 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


 void main() {
    runApp(MaterialApp(
      home:EditCredentials()
    ));
    }

 class EditCredentials extends StatefulWidget{
   @override
   MyApp2 createState()=> new MyApp2();
 }
 class MyApp2 extends State<EditCredentials> {
   // This widget is the root of your application.
   final TextEditingController controller= new TextEditingController();
   String results="";

   String name = "";
  String password = "";
  String cnic = "";
  String phone = "";
  String address = "";
  String email = "";

  updateFirebaseDB() async {
      FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
     await Firestore.instance.collection('MyUser').document(user.uid).setData(
       {
      'User_name': name,
      'User_password': password,
      'User_cnic' : cnic,
      'User_phone' : phone,
      'User_email' : email,
      'User_address' : address,
      'User_id' : user.uid,

    }
    );
    
    print("updated data on firebase");
  }

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,

       theme: ThemeData(
         primarySwatch: Colors.teal,
       ),
       home: Scaffold(appBar: AppBar(title: Text('Edit Credentials'),
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
               image: AssetImage('assets/des.jpg')),
         ),

         margin: EdgeInsets.only(left:10,right:10),
         child:Column(children: <Widget>[

                Expanded( child:
                  Container(
                    margin: EdgeInsets.all(4.0),
                    child: Text('Please fill all the fields,if you do not want to edit a particular field,fill it with old data of yours.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left))) ,
                Expanded(child:TextField(
                  onChanged: (text) {
                                name = text;
                              },
                  decoration: InputDecoration(hintText: 'Username...')
                )),

                Expanded(child:TextField(
                    onChanged: (text) {
                                password = text;
                              },
                  decoration: InputDecoration(hintText: 'Password...')
                )),

                Expanded(child:TextField(
                  decoration: InputDecoration(hintText: 'Confirm Password...')
                )),

                Expanded(child:TextField(
                    onChanged: (text) {
                                email = text;
                              },
                  decoration: InputDecoration(hintText: 'Email...')
                )),

                Expanded(child:TextField(
                    onChanged: (text) {
                                phone = text;
                              },
                  decoration: InputDecoration(hintText: 'Phone number...')
                )),

                Expanded(
                  child:TextField(
                      onChanged: (text) {
                                address = text;
                              },
                  decoration: InputDecoration(hintText: 'Adress...')
                )),


                  Expanded(child:TextField(
                      onChanged: (text) {
                                cnic = text;
                              },
                  decoration: InputDecoration(hintText: 'CNIC...')
                )),

                Expanded(child:
                Container(
                  alignment:Alignment.bottomRight,
                  margin:  EdgeInsets.all(4.0),

                child:RaisedButton(

                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child:Text('Update',
                    style: TextStyle(
                    color: Colors.white,
                  )) ,
                  color: Colors.teal,
                  onPressed: (){
                    updateFirebaseDB();
                   

                  },)))

         ])
         ,)
        ),
      );

   }
 }
