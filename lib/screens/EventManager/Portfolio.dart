import 'dart:async';
import 'dart:io';

import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'ViewProfile.dart';

//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Portfolio()));
//}


class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  File sampleImage;
  String ImageUrl;
  bool loading = false;
  final formkey= new GlobalKey<FormState>();



  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      sampleImage = picture;
    });

    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      sampleImage = picture;
    });
    Navigator.of(context).pop();
  }

  bool validateAndSave(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  Future  saveCoverToDatabase(String ImgUrl)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    DocumentReference docref=Firestore.instance.collection("Event_manager").document(user.uid);
    DocumentSnapshot doc=await docref.get();
    List portfolio=doc.data['Event_portfolio'];
    portfolio.add(ImgUrl);
    docref.updateData({'Event_portfolio': FieldValue.arrayUnion(portfolio)});
    int length=portfolio.length;
    print('porfolio length:$length');
  }


  Future uploadStatusImage() async {

    if(validateAndSave()){
      final StorageReference postCoverRef=FirebaseStorage.instance.ref().child("portfolio");
      var timeKey=new DateTime.now();
      final StorageUploadTask uploadTask=postCoverRef.child(timeKey.toString()+ ".jpg").putFile(sampleImage);
      var imgUrl=await(await  uploadTask.onComplete).ref.getDownloadURL();
      ImageUrl=imgUrl.toString();
      print("portfolio photo url: "+ ImageUrl);
      gotoProfilePage();
      saveCoverToDatabase(ImageUrl);
    }
  }
  void gotoProfilePage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return View();
    }));
  }
  Future<void> _showDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            backgroundColor: Colors.grey,
            // contentPadding: EdgeInsets.all(10.0),
            title: Text(
              "Make a Choice!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25.0,
              ),
            ),
            content: SingleChildScrollView(
                child: ListBody(
                    children: <Widget>[
                      GestureDetector(

                        child: Text("Gallery"),
                        onTap: () {
                          _openGallery(context);
                        },
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      GestureDetector(
                        child: Text("Camera"),
                        onTap: () {
                          _openCamera(context);
                        },
                      ),
                    ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading()
        : new MaterialApp(
        debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: new AppBar(
              title: new Text('Upload Image'),
              centerTitle: true,
              backgroundColor: Colors.teal,
              elevation: 0.0,
              leading:IconButton(
                onPressed: (){
                  //Navigator.of(context).pop();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => View()));
                },
                icon: Icon(Icons.arrow_back),
              ),

            ),
      body:

       Container(
          height:651.0,
          decoration: new BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background15.jpg')),
          ),
          child: Column(
            children: <Widget>[

              sampleImage == null ?
              Column(
                children: <Widget>[
                  SizedBox(height: 300,),
                  new Center(
                    child: Text('Select an image'),
                  ),
                  SizedBox(height: 265,),
                  RaisedButton(
                    //color: Colors.teal[400],
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        side: BorderSide(
                          color: Colors.teal, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                    child:Shimmer.fromColors(
                        period: Duration(milliseconds: 1500),
                        baseColor: Colors.white,
                        highlightColor: Colors.tealAccent,
                      child: Text(
                        'Select',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily:'Pacifico',
                            //color: Colors.white
                        ),
                      ),),
                      elevation: 10.0,
                      //splashColor: Colors.black12,
                      color: Colors.teal,
                      onPressed: () {
                        _showDialog1(context);
                      }),

                ],
              )
                  : enableUpload()
            ],
          ),
        ),
      ),
    );

  }

  Widget enableUpload(){
    final manager = Provider.of<EventManager>(context);
    return StreamBuilder<EventManager>(
        stream: EventManager(uid: manager.uid).managerdata,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            EventManager managerData=snapshot.data;
            return Container(
              child: new Form(
                key: formkey,
                child:  Column(
                  children: <Widget>[
                    SizedBox(height: 35.0),
                    Image.file(sampleImage,height: 530,width: 860,),
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
                      child:Shimmer.fromColors(
                          period: Duration(milliseconds: 1500),
                          baseColor: Colors.white,
                          highlightColor: Colors.tealAccent,
                        child: Text(
                          'Upload',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              fontFamily:'Pacifico',
                          //    color: Colors.white
                          ),
                        ),),
                        elevation: 10.0,
                        //splashColor: Colors.black12,
                        color: Colors.teal,
                        onPressed: ()async {
                          setState(() => loading = true);
                          uploadStatusImage();
                        })

                  ],
                ),




              ),
            );

          }else{
            return Loading();
          }

        }
    );






  }



}
