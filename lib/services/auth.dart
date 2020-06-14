//import 'dart:js';

// ignore: avoid_web_libraries_in_flutter
//import 'dart:js';

import 'package:ajeeb/services/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:ajeeb/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ajeeb/models/eventManager.dart';


//import 'database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var context;

  //BuildContext context;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  EventManager _eventManagerFromFirebaseUser(FirebaseUser user) {
    return user != null ? EventManager(uid: user.uid) : null;
  }

  // auth change manager stream
  Stream<EventManager> get eventManager {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _eventManagerFromFirebaseUser(user));
        .map(_eventManagerFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register user with email and password
  Future registerUserWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  //register manager with email and password
  Future registerManagerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }



  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}