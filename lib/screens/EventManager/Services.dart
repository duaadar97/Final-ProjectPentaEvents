import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/screens/EventManager/ViewProfile.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Services()));
//}


class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String _service;

  final _formKey = GlobalKey<FormState>();

  Future saveToDatabase(String ser) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    DocumentReference docref = Firestore.instance.collection("Event_manager").document(user.uid);
    docref.updateData({'Event_services': FieldValue.arrayUnion([ser])});
  }
  Future delFromDatabase(String ser) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    DocumentReference docref = Firestore.instance.collection("Event_manager").document(user.uid);
    docref.updateData({'Event_services': FieldValue.arrayRemove([ser])});

  }
  Future updateToDatabase(String ser,int index) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    DocumentReference docref = Firestore.instance.collection("Event_manager").document(user.uid);
    DocumentSnapshot doc=await docref.get();
    List services=doc.data['Event_services'];
    services[index]=ser;
    print(services);
    docref.updateData({'Event_services': services});
  }

  @override
  Widget build(BuildContext context) {
    final eventManager = Provider.of<EventManager>(context);
    final title = 'Services';


    return MaterialApp(

    debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading:IconButton(
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => View()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.teal,
        ),
        body:StreamBuilder<EventManager>(
          stream: EventManager(uid: eventManager.uid).managerdata,
          builder: (context, snapshot) {
            if(snapshot.hasData){
            EventManager managerData=snapshot.data;
            return Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/backgorund3.jpg')),
                    ),
                    child:new Center(
                      child: managerData.services.length==0?
                      Text("Add Service",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                        color: Colors.teal),
                      ):Container(
                        child: new ListView.builder(
                          itemCount: managerData.services.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new Column(
                              children: <Widget>[
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(width: 5.0,),
                                    Text(managerData.services[index]),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed:() {
                                        _Description1(context, index);
                                        },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: (){
                                        delFromDatabase(managerData.services[index]);
                                        //Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Services()));

                                      },
                                    ),

                                  ],
                                ),
                                new Divider(height: 2.0,),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ),
                  Positioned(
                    right: 10.0,
                    bottom: 10.0,
                    child: new FloatingActionButton(
                      child: const Icon(Icons.add),
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        _Description(context);


                      },
                    ),
                  ),
                ],

              ),
            );

            }else{
              return Loading();
            }

          }
        )
      ),
    );
  }

  Future<void> _Description(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Add Service",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 20.0,
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      autofocus: false,
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
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter Service'
                          : null,
                      onChanged: (val) {
                        setState(() => _service = val);
                      },
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      //color: Colors.teal[400],
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(
                            color: Colors.teal,
                            //Color of the border
                            style: BorderStyle.solid,
                            //Style of the border
                            width: 2.0, //width of the border
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        elevation: 10.0,
                        //splashColor: Colors.black12,
                        color: Colors.teal,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await saveToDatabase(_service);
                            Navigator.of(context).pop();
                            //Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Services()));
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
  Future<void> _Description1(BuildContext context,int index){

    return showDialog(
        context: context,
        builder: (BuildContext context){
          final manager = Provider.of<EventManager>(context);
          return StreamBuilder<EventManager>(
              stream:EventManager(uid: manager.uid).managerdata,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  EventManager managerData=snapshot.data;
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    backgroundColor: Colors.white,
                    title: Text(
                      "Edit Service",
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
                              initialValue: managerData.services[index],
                              autofocus: false,
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
                              validator: (val)=> val.isEmpty? 'Enter Service': null,
                              onChanged: (val){
                                setState(() => _service = val);
                              },
                            ),
                            SizedBox(height: 10.0),
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
                                  'Done',
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
                                    await updateToDatabase(_service ?? managerData.services[index],index);
                                    Navigator.of(context).pop();
                                    //Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Services()));
                                  }


                                })
                          ],
                        ),
                      ),
                    ),
                  );
                }else{
                  return Loading();
                }

              }
          );
        }
    );

  }
}
