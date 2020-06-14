import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_search_panel/flutter_search_panel.dart';
import 'package:flutter_search_panel/search_item.dart';

// void main() => runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'AppBar Scaffold',
//     theme: ThemeData(
//       primarySwatch: Colors.teal,
//     ),
//     home: MyBooking(data)));

class MyBooking extends StatefulWidget {
    String data;
  MyBooking(this.data);
  @override
  _MyBookingState createState() => _MyBookingState(data);
}

class _MyBookingState extends State<MyBooking> {
  String results = "";
  String data;
  _MyBookingState(this.data);
@override
 void didChangeDependencies(){
  super.didChangeDependencies();
    print("print d");
    print(this.data);

    fetchFromFirebase();

 }
  String name = "";
  String phone = "";
  String address = "";
  String email = "";
  String startdate = "Start Date";
 
  String enddate = "End Date";
  String noofpeople = "";
  String estimatedcost = "0.0";
  
  confirmBooking(BuildContext context) async {
    var alertDialog = AlertDialog(
        title: Text("Event Booked Successfully "),
        content: Text("Have a Happy event! "),
        actions: <Widget>[
          RaisedButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0),
            ),
            child: Text('Ok'),
            onPressed: (){
              Navigator.of(context,rootNavigator:true).pop();
            

            // child: const Text("Ok"),
                 // onPressed: _dismissDialog,
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return CustLogIn();
//            }));
            },
            elevation: 10.0,
            color: Colors.teal,
          )
        ]);

    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    await Firestore.instance.collection('Event_Bookings').document(user.uid).setData({
      'name': name,
      'cat': cat,
      'phone': phone,
      'packages': packages,
      'address': address,
      'theme': theme,
      'email': email,
      'startdate': startdate,
      'enddate': enddate,
      'addservice': addservice,
      'noofpeople': noofpeople,
      'estimatedcost': estimatedcost,
      'User_id': user.uid,
    });


await Firestore.instance.collection('Event_manager').document(this.data).updateData({'Event_categories': FieldValue.arrayUnion([name])});

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
    print("event was success");
  }

   String addservice = "Services";
   String cat = "Category";
  String packages = "Packages";
  String theme = "Themes";


  var  catlist = <String>["Category"];
  
  var packagelist = <String>[
    "Packages",
    "Transport",
    
    "Shopping",
    "Medical",
    "Gold",
    "Silver",
    "Platinum"
  ];
  var themelist = <String>["Themes"];
  var servicelist = <String>["Services"];
  var servicelistPrices = <String>[
    "200",
    "250",
    "900",
    "250",
    "700",
    "250",
    "400",
    "550", 
    "250",
    "700",
    "250",
    "400",
    "550", 
    "250",
    "700",
    "250",
    "400",
    "550", 
    "550", 
    "250",
    "700",
    "250",
    "400",
    "550", 
    "200",
    "250",
    "900",
    "250",
    "700",
    "250",
    "400",
    "550", 
    "250",
    "700",
    "250",
    "400",
    "550", 
    "250",
    "700",
    "250",
    "400",
    "550", 
    "550", 
    "250",
    "700",
    "250",
    "400",
    "550",
    ];
 
  String dropdownValue = 'One';
fetchFromFirebase (){
  print("this is a msgsss");
    Firestore.instance.collection("Event_manager")
    .document(this.data).get()
    .then( (snapshot) {
      print("printing data ");
      // List<String>.from(snapshot["Event_categories"]).fromMap(Map<String, dynamic> data) {
      //       catlist = data['Event_categories'].cast<String>();
      //   }
      for(int i =0;i<snapshot["Event_categories"].length;i++){
        catlist.add( snapshot["Event_categories"][i]);
      }
      for(int i =0;i<snapshot["Event_themes"].length;i++){
        themelist.add( snapshot["Event_themes"][i]);
      }
      for(int i =0;i<snapshot["Event_services"].length;i++){
        servicelist.add( snapshot["Event_services"][i]);
      }

        //  catlist  = parsed;
      this.setState(() {
                   });
      print(catlist);
      
    } );
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,

        title: Text("Booking"),
        // color: Colors.teal,
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/backgorund3.jpg')),
        ),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        margin: EdgeInsets.only(left: 17),
                        child: Column(children: <Widget>[
                          TextFormField(
                            onChanged: (text) {
                              print(text);
                              name = text;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal)),
                              contentPadding:
                                  EdgeInsets.only(top: 40.0, left: 10),
                              hintText: "Name...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              phone = text;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal)),
                              contentPadding:
                                  EdgeInsets.only(top: 40.0, left: 10),
                              hintText: "Phone...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              address = text;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal)),
                              contentPadding:
                                  EdgeInsets.only(top: 40.0, left: 10),
                              hintText: "Address...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              email = text;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal)),
                              contentPadding:
                                  EdgeInsets.only(top: 40.0, left: 10),
                              hintText: "Email...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          dropdownmenu(catlist,"cat"),
                          // buildListSelectionWidget(catlist,"cat"),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              noofpeople = text;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal)),
                              contentPadding:
                                  EdgeInsets.only(top: 40.0, left: 10),
                              hintText: "No of People...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ])),
                    Container(

                      // changes  
                      
                        width: MediaQuery.of(context).size.width * 0.40,
                        margin: EdgeInsets.only(left: 15),
                        child: Column(children: <Widget>[
                           dropdownmenu(servicelist, "service"),
                          // buildListSelectionWidget(servicelist, "service"),
                          SizedBox(
                            height: 15,
                          ),
                           dropdownmenu(themelist, "theme"),
                          // buildListSelectionWidget(themelist, "theme"),
                          SizedBox(
                            height: 15,
                          ),
                           dropdownmenu(packagelist, "package"),
                          // buildListSelectionWidget(packagelist, "package"),
                          SizedBox(
                            height: 15,
                          ),
                          FlatButton(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2020, 1, 5),
                                    maxTime: DateTime(2040, 12, 7),
                                    onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  startdate = date.toString().split(" ")[0];
                                  print('confirm $date');
                                  this.setState((){
                                    startdate  = startdate;
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                              // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              alignment: Alignment.center,
                              height: 60,
                              width: 500,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.4), // set border color
                                    width: 1.0), // set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0)), // set rounded corner radius
                              ),
                              child:Text(startdate)
                             ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
                            FlatButton(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2020, 1, 5),
                                    maxTime: DateTime(2040, 12, 7),
                                    onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date){
                                  enddate = date.toString().split(" ")[0];
                                  print('confirm $enddate');
                                  this.setState((){
                                    enddate  = enddate;
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                              // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              alignment: Alignment.center,
                              height: 60,
                              width: 500,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.4), // set border color
                                    width: 1.0), // set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0)), // set rounded corner radius
                              ),
                              child:Text(enddate)
                             ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            onChanged: (text) {
                              // estimatedcost = text;
                            },
                            
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal)),
                              contentPadding:
                                  EdgeInsets.only(top: 40.0, left: 10),
                              hintText: "Est cost: "+estimatedcost,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ]))
                  ],
                )),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              height: 55.0,
              width: 200.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  confirmBooking(context);
                },
                child: Text("Book"),
                elevation: 6.0,
                //splashColor: Colors.black12,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FormField<String> dropdownmenu(list, option) {
    // String myvaue = "One";
    return FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  // labelStyle: textStyle,
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 14.0),
                                  hintText: 'Please select expense',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                              // isEmpty: _currentSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: option == "cat"
                                          ? cat 
                                          : option == "service"
                                              ? addservice 
                                              : option == "theme"
                                                  ? theme 
                                                  : option == "package"
                                                      ? packages 
                                                      : null,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 18,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  
                                  onChanged: (String newValue) {
                                    if(option=="service"){
                                  int index = servicelist.indexOf(newValue);
                                  estimatedcost = servicelistPrices[index];
                                    }
                                 

                                    option == "cat"
                                  ? setState(() {cat = newValue;})
                                  : option == "service"
                                      ? setState(() {addservice = newValue;})
                                      : option == "theme"
                                          ? setState(() {theme = newValue;})
                                          : option == "package" ? setState(() {packages = newValue;}) :print("exception");
                                    
                                  },
                                  items: list.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        );
  }

  Container buildListSelectionWidget(list, option) {
    return Container(
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0),
        border: Border.all(
            color: Colors.black.withOpacity(0.5), // set border color
            width: 1.0), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(15.0)), // set rounded corner radius
      ),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: option == "cat"
                  ? Text(cat)
                  : option == "service"
                      ? Text(addservice)
                      : option == "theme"
                          ? Text(theme)
                          : option == "package" ? Text(packages) : Text("")),
          Opacity(
            opacity: 0,
            child: FlutterSearchPanel<int>(
              padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
              selected: 3,
              // title: 'Select Categories',
              data: list,
              icon: new Icon(Icons.error, color: Colors.black),
              color: Colors.blue,
              textStyle: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  decorationStyle: TextDecorationStyle.solid),
              onChanged: (int value) {
                option == "cat"
                    ? cat = list[value].text.toString()
                    : option == "service"
                        ? addservice = list[value].text.toString()
                        : option == "theme"
                            ? theme = list[value].text.toString()
                            : option == "package"
                                ? packages = list[value].text.toString()
                                : print("exception");

                print(value);
                print(option);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// void confirmBookingbackup(BuildContext context) {
//   var alertDialog=AlertDialog(
//     title:Text("Event Booked Successfully "),
//     content:Text("Have a Happy event! "),
//       actions: <Widget>[
//         RaisedButton(
//           shape: new RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(15.0),
//           ),
//           child: Text('Ok'),
//           onPressed: () {
// //            Navigator.push(context, MaterialPageRoute(builder: (context) {
// //              return CustLogIn();
// //            }));
//           },
//           elevation: 10.0,
//           color: Colors.teal,
//         )
//       ]

//   );

//   showDialog(
//       context:context,
//       builder: (BuildContext context){
//         return alertDialog;
//       }
//   );

// }



