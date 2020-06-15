import 'dart:io';
import 'dart:ui';
import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/screens/EventManager/uploadCover.dart';
import 'package:ajeeb/screens/EventManager/uploadLogo.dart';
import 'package:ajeeb/services/auth.dart';
import 'package:ajeeb/shared/constants.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ajeeb/models/eventManager.dart';
import 'EditCredentials.dart';
import 'Portfolio.dart';
import 'Services.dart';
import 'Themes.dart';
import 'Category.dart';




//void main() {
//  FlutterError.onError = (FlutterErrorDetails details) {
//    FlutterError.dumpErrorToConsole(details);
//    if (kReleaseMode)
//      exit(1);
//  };
//
//  runApp(new View());}

class View extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penta Events',
      home: new MyEvents(),
    );
  }
}

class MyEvents extends StatefulWidget {
  _MyEvents createState() => _MyEvents();
}

class _MyEvents extends State<MyEvents> {


  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  String _description;


    Future getUrls()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    DocumentReference docref=Firestore.instance.collection("Event_manager").document(user.uid);
    DocumentSnapshot doc=await docref.get();
    List portfolio=doc.data['Event_portfolio'];
    return portfolio;
  }



  List<Widget> _buildGridTiles(List portfolio) {

    List<Container> containers = new List<Container>.generate(portfolio.length,
            (int index) {
              return new Container(
                  child: GestureDetector(
                    child: Image(
                      image: NetworkImage(portfolio[index],),
                        fit: BoxFit.fill,
                    ),
                    onTap: (){
                      _showImage(context,portfolio[index]);
                    },
                  ),
              );
        });
    return containers;
  }



  Widget _showImage(BuildContext context,String image){
      return Scaffold(
        appBar: new AppBar(
          title: new Text('Upload Image'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 0.0,
        ),
        body: Container(
          child: Image(
            image: NetworkImage(image),
            fit: BoxFit.fill,
          ),
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    final eventManager = Provider.of<EventManager>(context);
    return StreamBuilder<EventManager>(
        stream: EventManager(uid: eventManager.uid).managerdata,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            EventManager managerData=snapshot.data;
            return new Scaffold(
                appBar: new AppBar(
                  title: new Text('Penta Events'),
                  backgroundColor: Colors.teal,
                ),
                drawer: new Drawer(
                  child: new ListView(
                    children: <Widget>[
                      new UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.teal),
                        accountName: new Text(managerData.orgName),
                        accountEmail: new Text(managerData.email),
                        currentAccountPicture: new GestureDetector(
                          child: new CircleAvatar(
                            backgroundImage:managerData.logo=='logo'?AssetImage('assets/logo1.jpg') :NetworkImage(managerData.logo),
                          ),
                        ),
                      ),
                      //
                      new ListTile(
                        leading: new Icon(Icons.category),
                        title: new Text('Categories'),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return MyCategory();
                                        }));
                                      },
                      ),

                      new ListTile(
                        leading: new Icon(Icons.color_lens),
                        title: new Text('Themes'),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return MyThemes();
                                        }));
                                      },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.edit),
                        title: new Text('Edit Credentials'),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return EditCredentials();
                                        }));
                                      },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.calendar_today),
                        title: new Text('Services'),
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Services();

                                        }
                                        ));

                                      },
                      ),

                    ],
                  ),
                ),
                body: Container(
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/background15.jpg')),
                  ),

                  child: new ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Stack(children: <Widget>[

                                          Container(

                                            height: 230.0,
                                            child: new Center(
                                              child: managerData.cover =='cover'? Text(
                                                "Upload Cover",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                              ) : Container(
                                                height: 230.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(managerData.cover))),
                                              ),
                                            ),
                                          ),


                                          IconButton(
                                            icon: Icon(Icons.add_a_photo),
                                            color: Colors.black,
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return UploadCoverPage();
                                                      }));
                                            },
                                          )
                                        ]
                                        )
                                    )
                                  ],
                                ),
                                Positioned(
                                  top: 130.0,
                                  child: Stack(children: <Widget>[
                                    Container(
                                        height: 95.0,
                                        width: 95.0,
                                        child: new Center(
                                          child: managerData.logo== 'logo' ? Container(
                                            height: 230.0,
                                            width: 230,
                                            decoration: BoxDecoration(

                                                shape: BoxShape.circle,
                                                image: DecorationImage(

                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        'assets/logo1.jpg')

                                                ),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3.0)),
                                          ) : Container(
                                            height: 230.0,
                                            width: 230,
                                            decoration: BoxDecoration(

                                                shape: BoxShape.circle,
                                                image: DecorationImage(

                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(managerData.logo)

                                                ),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3.0)),
                                          ),
                                        )
                                    ),
                                    //                          _decideImageView(),
                                    IconButton(
                                      icon: Icon(Icons.add_a_photo),
                                      color: Colors.black,
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return UploadLogoPage();
                                            }));
                                      },
                                    )
                                  ]),
                                )
                              ],
                            ),
                          ),
//                          Container(
//                            height: 12.0,
//                            child: Divider(
//                              color: Colors.grey,
//                            ),
//                          ),

                                          Container(
                                            height: 60,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(managerData.orgName,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold, fontSize: 25.0,color: Colors.white))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.location_on,
                                                    size: 20.0,),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(managerData.address,
                                                      style: TextStyle(fontSize: 16.0),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.phone,size: 20.0,),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(managerData.phone,
                                                      style: TextStyle(fontSize: 16.0),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.mail,size: 20.0,),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(managerData.email,
                                                      style: TextStyle(fontSize: 16.0),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.access_time,size: 20.0,),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text('9:00 AM - 5:00 PM',
                                                      style: TextStyle(fontSize: 16.0),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.location_city,size: 20.0,),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(managerData.servingAreas,
                                                      style: TextStyle(fontSize: 16.0),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                          Container(
                            height: 12.0,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(7.0),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.all(1.0),
                                          alignment: Alignment.topLeft,
                                          child: Text("Description",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.black,
                                        onPressed: () {
                                          _Description(context,managerData.description);
                                          },
                                      )
                                    ],
                                  ),

                                  Container(
                                    margin: EdgeInsets.all(1.0),
                                    alignment: Alignment.topLeft,
                                    child:managerData.description==null?
                                    Text('Enter Description',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontStyle: FontStyle.italic
                                      ),
                                    )
                                        :Text(managerData.description,
                                      style: TextStyle(
                                        fontSize: 16.0,

                                      ),
                                    )
                                  ),
                                ],
                              )),
                          Container(
                            height: 12.0,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(7.0),
                              //alignment: Alignment.topLeft,
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(
                                      "Porfolio",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //leading: new Icon(Icons.color_lens),
                                    IconButton(icon: Icon(Icons.add_a_photo),
                                      //alignment: Alignment.topRight,

                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Portfolio();

                                        }));

                                      },)
                                  ]),
                                  Container(//height: 300.0,
                                    margin: EdgeInsets.all(1.0),
                                    alignment: Alignment.topLeft,
                                    child: managerData.portfolio.length==0? Text(
                                      "Upload Portfolio ",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                          fontStyle: FontStyle.italic
                                        //fontWeight: FontWeight.bold
                                      ),
                                    ) :     Center(
                                      child: Container(
                                        //height: 300.0,
                                        child: new GridView.extent(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          maxCrossAxisExtent: 150.0,
                                          mainAxisSpacing: 5.0,
                                          crossAxisSpacing: 5.0,
                                          padding: const EdgeInsets.all(5.0),
                                          children: _buildGridTiles(managerData.portfolio),//Where is this function ?
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),


                          ),
                          Container(
                            height: 15.0,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(7.0),

                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Customers",
                                    style: TextStyle(fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(1.0),
                                  alignment: Alignment.topLeft,
                                  child: managerData.customers.length==0?
                                  Text("No Customers Yet!",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                          fontStyle: FontStyle.italic
                                        //fontWeight: FontWeight.bold
                                      ),
                                  ):Container(
                                    child: new ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: managerData.customers.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return new Column(
                                          children: <Widget>[
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SizedBox(width: 5.0,),
                                                Icon(Icons.arrow_right),
                                                Text(managerData.customers[index],
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    //fontWeight: FontWeight.bold
                                                  ),),
                                              ],
                                            ),

                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),


                        ],
                      )
                    ],
                  ),
                )
            );
          }else{

            return Loading();
          }

        }
    );
  }


  Future<void> _Description(BuildContext context,String description){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  backgroundColor: Colors.white,
                  title: Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 25.0,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: ListBody(
                        children: <Widget>[
                          TextFormField(
                            initialValue: description,
                            autofocus: false,
                            maxLines: 8 ,
                            decoration: new InputDecoration(

                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                  //Color of the border
                                  style: BorderStyle.solid,
                                  //Style of the border
                                  width: 2.5, //width of the border
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (val)=> val.isEmpty? 'Enter Description': null,
                            onChanged: (val){
                              setState(() => _description = val);
                            },
                          ),
                          SizedBox(height: 35.0),
                          RaisedButton(
                            //color: Colors.teal[400],
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                side: BorderSide(
                                  color: Colors.teal, //Color of the border
                                  style: BorderStyle.solid, //Style of the border
                                  width: 2.0, //width of the border
                                ),
                              ),
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                    color: Colors.white),
                              ),
                              elevation: 10.0,
                              //splashColor: Colors.black12,
                              color: Colors.teal,
                              onPressed: ()async {
                                if(_formKey.currentState.validate()){
                                   await UploadDescription(_description ?? description);
                                    Navigator.of(context).pop();
                                }


                              })
                        ],
                      ),
                    ),
                  ),
                );


        }
    );

  }
  Future UploadDescription(String des)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Description': des,
    });
    gotoProfilePage();


  }
  void gotoProfilePage(){
    //Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return View();
    }));
  }
}