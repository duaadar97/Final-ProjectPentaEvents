import 'package:ajeeb/models/eventManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference managerCollection = Firestore.instance.collection("Event_manager");

  Future<void> addToDatabase(String name,
      String email,
      String password,
      String orgName,
      String cnic,
      String phone,
      String address,
      String servingArea,



      ) async {
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    FirebaseUser user = await _auth.currentUser();
     return await managerCollection.document(uid).setData({
      'Event_name': name,
      'Event_password': password,
      'Event_orgName': orgName,
      'Event_cnic': cnic,
      'Event_phone': phone,
      'Event_address': address,
      'Event_serving_areas': servingArea,
      'Event_id': uid,
      'Event_email': email
    });
  }

  //manager data from snap shot
  EventManager _managerDataFromSnapshot(DocumentSnapshot snapshot) {
    return EventManager(
      uid: uid,
      email: snapshot.data['Event_email'],
      password: snapshot.data['Event_password'],
      username: snapshot.data['Event_name'],
      cnic: snapshot.data['Event_cnic'],
      phone: snapshot.data['Event_phone'],
      address: snapshot.data['Event_address'],
      orgName: snapshot.data['Event_orgName'],
      servingAreas: snapshot.data['Event_serving_areas'],



    );
  }

 //get manager doc stream
    Stream<EventManager> get managerdata{
    return managerCollection.document(uid).snapshots().map(_managerDataFromSnapshot);
  }

}