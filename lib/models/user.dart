import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {

  final String uid;
  final String email;
  final String password;
  final String username;
  final String cnic;
  final String phone;
  final String address;
  User({ this.uid , this.email, this.password, this.username,
    this.cnic, this.phone, this.address

  });

  Future<void> addToDatabase(String name,
      String email,
      String password,
      String cnic,
      String phone,
      String address,

      ) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection('MyUser').document(user.uid).setData({
      'User_name': name,
      'User_password': password,
      'User_cnic' : cnic,
      'User_phone' : phone,
      'User_address' : address,
      'User_email' :email,
      'User_id' : user.uid,

    });

  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        email: snapshot.data['User_email'],
        password: snapshot.data['User_password'],
        username: snapshot.data['User_name'],
        cnic: snapshot.data['User_cnic'],
        phone: snapshot.data['User_phone'],
        address: snapshot.data['User_address'],

    );
  }

  Stream<User> get userdata{
    return Firestore.instance.collection('MyUser').document(uid).snapshots().map(_userDataFromSnapshot);
  }




}