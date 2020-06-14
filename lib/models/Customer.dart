import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Customer {

  final String uid;
  final String email;
  final String password;
  final String username;
  final String cnic;
  final String phone;
  final String address;

  Customer({ this.uid , this.email, this.password, this.username,
    this.cnic, this.phone, this.address

  });


  Future<void> addToDatabase(String name,
      String email,
      String password,
      String cnic,
      String phone,
      String address
//    String uid,
//    String cnic,
//    String phone, String address

      ) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection('MyUser').document(user.uid).setData({
      'User_name': name,
      'User_password': password,
      'User_cnic' : cnic,
      'User_phone' : phone,
      'User_address' : address,

      'User_id' : user.uid,

    });
//  String uid = FirebaseAuth.getInstance().getCurrentUser().getUid();
//  FirebaseFirestore rootRef = FirebaseFirestore.getInstance();
//  DocumentReference uidRef = rootRef.collection("users").document(uid);


//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final Firestore _firestore = Firestore.instance;
//
//    FirebaseUser user = await _auth.currentUser();
//    DocumentReference ref = _firestore.collection('Customer').document(user.uid).setData({
//      'User_id': user.uid,
//      'User_email': user.email,
//      //'User_password': user.password,
//    }) as DocumentReference;
//    //return ref;
  }


}