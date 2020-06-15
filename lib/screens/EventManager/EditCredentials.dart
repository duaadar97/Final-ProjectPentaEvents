

//import 'dart.html';
import 'dart:io';

import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/models/user.dart';
import 'package:ajeeb/services/DatabaseService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ajeeb/services/auth.dart';
//import 'package:ajeeb/services/database.dart';
import 'package:ajeeb/shared/constants.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'ViewProfile.dart';
//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: EditCredentials()));
//}
class EditCredentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

    debugShowCheckedModeBanner: false,
      title: 'Penta Events',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new Credentials(),
    );
  }
}

class  Credentials extends StatefulWidget {
  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();



  // text field state
  String _username = '';
  String _address = '';
  String _cnic = '';
  String _phone_no = '';
  String _organizationName='';
  String _servingAreas='';

  Future updateUsername(String name)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_name': name,
    });
  }
  Future updatePhoneNo(String phone)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_phone': phone,
    });
  }
  Future updateCnic(String cnic)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_cnic': cnic,
    });
  }
  Future updateAddress(String address)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_address': address,
    });
  }
  Future updateOrgName(String org)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_orgName': org,
    });
  }
  Future updateServingAreas(String areas)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_serving_areas': areas,
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventManager = Provider.of<EventManager>(context);
    return StreamBuilder<EventManager>(
        stream: EventManager(uid: eventManager.uid).managerdata,
        builder: (context, snapshot) {
          if(snapshot.hasData){
          EventManager managerData=snapshot.data;
          return Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                backgroundColor: Colors.teal,
                elevation: 0.0,
                title: Text('Edit Credentials'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return View();
                    }));
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body:Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/background15.jpg')),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Username:  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(managerData.username,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: (){
                                        _Updateusername(context,managerData.username);
                                      },
                                    ),
                                    new Divider(height: 2.0,),
                                  ],
                                ),
                                Container(
                                  height: 12.0,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Phone No:  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(managerData.phone,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: (){
                                          _UpdatephoneNo(context,managerData.phone);
                                      },
                                    ),
                                    new Divider(height: 2.0,),
                                  ],
                                ),
                                Container(
                                  height: 12.0,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Cnic:  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(managerData.cnic,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: (){
                                        _Updatecnic(context,managerData.cnic);
                                      },
                                    ),
                                    new Divider(height: 2.0,),
                                  ],
                                ),
                                Container(
                                  height: 12.0,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Address  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(managerData.address,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: (){
                                        _Updateaddress(context,managerData.address);
                                      },
                                    ),
                                    new Divider(height: 2.0,),
                                  ],
                                ),
                                Container(
                                  height: 12.0,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Organization Name:  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(managerData.orgName,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: (){
                                        _UpdateorgName(context,managerData.orgName);
                                      },
                                    ),
                                    new Divider(height: 2.0,),
                                  ],
                                ),
                                Container(
                                  height: 12.0,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Serving Areas  ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(managerData.servingAreas,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: (){
                                        _Updateareas(context,managerData.servingAreas);
                                      },
                                    ),
                                    new Divider(height: 2.0,),
                                  ],
                                ),
                                Container(
                                  height: 12.0,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
  Future<void> _Updateusername(BuildContext context, String username){
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.white,
        title: Text("Edit Username",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 25.0,),),
        content: SingleChildScrollView(
          child: Form(key: _formKey1,
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  initialValue: username,
                  autofocus: false,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                        color: Colors.teal,
                        style: BorderStyle.solid,
                        width: 2.5,),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),),),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    //Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    Pattern pattern = r'^[a-z0-9_-]{3,15}$';
                    RegExp regex = new RegExp(pattern);
                    if (val.isEmpty) {
                      return 'Please enter username';
                    } else if (!regex.hasMatch(val))
                      return 'Invalid username';
                    else
                      return null;
                  },
                  onChanged: (val) {
                    setState(() => _username = val);
                  },),
                SizedBox(height: 10.0),
                RaisedButton(shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.teal,
                    style: BorderStyle.solid, width: 2.0,),),
                    child: Text('Done',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white),),
                    elevation: 10.0,
                    color: Colors.teal,
                    onPressed: () async {
                      if (_formKey1.currentState.validate()) {
                        await updateUsername(_username ?? username);
                        Navigator.of(context).pop();
                      }
                    })
              ],),),),);
    } );
    }


  Future<void> _UpdatephoneNo(BuildContext context,phone){
    return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Phone Number", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey2,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: phone, autofocus: false, decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                keyboardType: TextInputType.text, textInputAction: TextInputAction.next,
                validator: (val) {
                  Pattern pattern =
                      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
                  RegExp regex = new RegExp(pattern);
                  if (val.isEmpty)
                    return 'please enter phone no';
                  else if (!regex.hasMatch(val))
                    return 'please enter a valid phone no';
                  else
                    return null;
                }, onChanged: (val){setState(() => _phone_no = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey2.currentState.validate()){
                      await updatePhoneNo(_phone_no ??phone);
                      Navigator.of(context).pop();}})],),),),);});}


  Future<void> _Updatecnic(BuildContext context,String cnic){
    return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Cnic", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey3,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: cnic, autofocus: false, decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                keyboardType: TextInputType.text, textInputAction: TextInputAction.next,
                validator: (val) {
                  Pattern pattern =
                      r'^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$';
                  RegExp regex = new RegExp(pattern);

                  if (val.isEmpty)
                    return 'please enter cnic';
                  else if (!regex.hasMatch(val))
                    return 'please enter a valid cnic';
                  else
                    return null;
                },onChanged: (val){setState(() => _cnic = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey3.currentState.validate()){
                      await updateCnic(_cnic ?? cnic);
                      Navigator.of(context).pop();}})],),),),);});}


  Future<void> _Updateaddress(BuildContext context, String address){
    return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Address", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey4,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: address, autofocus: false, decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                keyboardType: TextInputType.text, textInputAction: TextInputAction.next,
                validator: (val) {
                                  Pattern pattern =
                                      r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(val))
                                    return 'please enter a valid address';
                                  else
                                    return null;
                                },onChanged: (val){setState(() => _address = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey4.currentState.validate()){
                      await updateAddress(_address ?? address);
                      Navigator.of(context).pop();}})],),),),);});}


  Future<void> _UpdateorgName(BuildContext context,orgName){
    return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Organization Name", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey5,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: orgName, autofocus: false, decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                keyboardType: TextInputType.text, textInputAction: TextInputAction.next,
                validator: (val) {
                  //Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                  Pattern pattern = r'^[a-zA-Z0-9_-]{3,15}$';
                  RegExp regex = new RegExp(pattern);
                  if (val.isEmpty) {
                    return 'Please enter Organization Name';
                  } else if (!regex.hasMatch(val))
                    return 'Invalid Organization Name';
                  else
                    return null;
                },onChanged: (val){setState(() => _organizationName = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey5.currentState.validate()){
                      await updateOrgName(_organizationName ?? orgName);
                      Navigator.of(context).pop();}})],),),),);});}



  Future<void> _Updateareas(BuildContext context,areas){
    return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Serving Areas", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey6,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: areas, autofocus: false, decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                keyboardType: TextInputType.text, textInputAction: TextInputAction.next,
                validator: (val) {
                                  Pattern pattern =
                                       r'^[A-Za-z0-9_-]{3,15}$';
                                  RegExp regex = new RegExp(pattern);
                                  if (val.isEmpty) {
                                    return 'Please enter Serving Area';
                                  } else if (!regex.hasMatch(val))
                                    return 'Invalid Serving Area';
                                  else
                                    return null;
                                },onChanged: (val){setState(() => _servingAreas = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey6.currentState.validate()){
                      await updateServingAreas(_servingAreas ?? areas);
                      Navigator.of(context).pop();}})],),),),);});}


}

