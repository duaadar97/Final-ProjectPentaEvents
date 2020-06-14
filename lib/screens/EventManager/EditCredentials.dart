

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
  final _formKey = GlobalKey<FormState>();


  // text field state
  String username = '';
  String address = '';
  String cnic = '';
  String phone_no = '';
  String organizationName='';
  String servingAreas='';

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
                backgroundColor: Colors.teal[400],
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
                            image: AssetImage('assets/backgorund3.jpg')),
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
                                        _username(context);
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
                                          _phoneNo(context);
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
                                        _cnic(context);
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
                                        _address(context);
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
                                        _orgName(context);
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
                                        _areas(context);
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
  Future<void> _username(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
          final manager = Provider.of<EventManager>(context);
          return StreamBuilder<EventManager>(stream:EventManager(uid: manager.uid).managerdata, builder: (context, snapshot) {
                if(snapshot.hasData){EventManager managerData=snapshot.data;
                  return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    backgroundColor: Colors.white, title: Text("Edit Username", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
                    content: SingleChildScrollView(child: Form(key: _formKey,
                        child: ListBody(children: <Widget>[
                            TextFormField(initialValue: managerData.username, autofocus: false, decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                              keyboardType: TextInputType.text, textInputAction: TextInputAction.next,validator: (val) {
                                //Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                Pattern pattern = r'^[a-z0-9_-]{3,15}$';
                                RegExp regex = new RegExp(pattern);
                                if (val.isEmpty) {
                                  return 'Please enter username';
                                } else if (!regex.hasMatch(val))
                                  return 'Invalid username';
                                else
                                  return null;
                              }, onChanged: (val){setState(() => username = val);},),
                            SizedBox(height: 10.0),
                            RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                                child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                                elevation: 10.0, color: Colors.teal,
                                onPressed: ()async {
                                  if(_formKey.currentState.validate()){
                                    await updateUsername(username ?? managerData.username);
                                    Navigator.of(context).pop();}})],),),),);}else{return Loading();}});});}


  Future<void> _phoneNo(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      final manager = Provider.of<EventManager>(context);
      return StreamBuilder<EventManager>(stream:EventManager(uid: manager.uid).managerdata, builder: (context, snapshot) {
        if(snapshot.hasData){EventManager managerData=snapshot.data;
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Phone Number", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: managerData.phone, autofocus: false, decoration: new InputDecoration(
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
                }, onChanged: (val){setState(() => phone_no = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey.currentState.validate()){
                      await updatePhoneNo(phone_no ?? managerData.phone);
                      Navigator.of(context).pop();}})],),),),);}else{return Loading();}});});}


  Future<void> _cnic(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      final manager = Provider.of<EventManager>(context);
      return StreamBuilder<EventManager>(stream:EventManager(uid: manager.uid).managerdata, builder: (context, snapshot) {
        if(snapshot.hasData){EventManager managerData=snapshot.data;
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Cnic", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: managerData.cnic, autofocus: false, decoration: new InputDecoration(
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
                },onChanged: (val){setState(() => cnic = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey.currentState.validate()){
                      await updateCnic(cnic ?? managerData.cnic);
                      Navigator.of(context).pop();}})],),),),);}else{return Loading();}});});}


  Future<void> _address(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      final manager = Provider.of<EventManager>(context);
      return StreamBuilder<EventManager>(stream:EventManager(uid: manager.uid).managerdata, builder: (context, snapshot) {
        if(snapshot.hasData){EventManager managerData=snapshot.data;
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Address", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: managerData.address, autofocus: false, decoration: new InputDecoration(
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
                                },onChanged: (val){setState(() => address = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey.currentState.validate()){
                      await updateAddress(address ?? managerData.address);
                      Navigator.of(context).pop();}})],),),),);}else{return Loading();}});});}


  Future<void> _orgName(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      final manager = Provider.of<EventManager>(context);
      return StreamBuilder<EventManager>(stream:EventManager(uid: manager.uid).managerdata, builder: (context, snapshot) {
        if(snapshot.hasData){EventManager managerData=snapshot.data;
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Organization Name", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: managerData.orgName, autofocus: false, decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1.0)),
                  borderSide: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.5,),),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),),
                keyboardType: TextInputType.text, textInputAction: TextInputAction.next,
                validator: (val) {
                  //Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                  Pattern pattern = r'^[a-z0-9_-]{3,15}$';
                  RegExp regex = new RegExp(pattern);
                  if (val.isEmpty) {
                    return 'Please enter Organization Name';
                  } else if (!regex.hasMatch(val))
                    return 'Invalid Organization Name';
                  else
                    return null;
                },onChanged: (val){setState(() => organizationName = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey.currentState.validate()){
                      await updateOrgName(organizationName ?? managerData.orgName);
                      Navigator.of(context).pop();}})],),),),);}else{return Loading();}});});}



  Future<void> _areas(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      final manager = Provider.of<EventManager>(context);
      return StreamBuilder<EventManager>(stream:EventManager(uid: manager.uid).managerdata, builder: (context, snapshot) {
        if(snapshot.hasData){EventManager managerData=snapshot.data;
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white, title: Text("Edit Serving Areas", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0,),),
          content: SingleChildScrollView(child: Form(key: _formKey,
            child: ListBody(children: <Widget>[
              TextFormField(initialValue: managerData.servingAreas, autofocus: false, decoration: new InputDecoration(
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
                                },onChanged: (val){setState(() => servingAreas = val);},),
              SizedBox(height: 10.0),
              RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.teal, style: BorderStyle.solid, width: 2.0,),),
                  child: Text('Done', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),),
                  elevation: 10.0, color: Colors.teal,
                  onPressed: ()async {
                    if(_formKey.currentState.validate()){
                      await updateServingAreas(servingAreas ?? managerData.servingAreas);
                      Navigator.of(context).pop();}})],),),),);}else{return Loading();}});});}


}

