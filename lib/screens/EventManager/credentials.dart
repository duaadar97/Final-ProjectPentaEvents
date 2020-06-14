import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';




class credentialList extends StatefulWidget {
  @override
  _credentialListState createState() => _credentialListState();
}

class _credentialListState extends State<credentialList> {
  @override
  Widget build(BuildContext context) {
    final credentials=Provider.of<QuerySnapshot>(context);
    var doc=credentials.documents;


    return Container();
  }
}
