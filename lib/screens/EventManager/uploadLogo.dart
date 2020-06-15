import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/screens/EventManager/ViewProfile.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';



//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: UploadLogoPage()));
//}


class UploadLogoPage extends StatefulWidget {
  @override
  _UploadLogoPageState createState() => _UploadLogoPageState();
}

class _UploadLogoPageState extends State<UploadLogoPage> {
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
  Future  saveCoverToDatabase(String logoUrl)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection("Event_manager").document(user.uid).updateData({
      'Event_Logo': logoUrl,

    });

  }

  void uploadStatusImage() async {
    if(validateAndSave()){
      final StorageReference postCoverRef=FirebaseStorage.instance.ref().child("Logo Photo");
      var timeKey=new DateTime.now();
      final StorageUploadTask uploadTask=postCoverRef.child(timeKey.toString()+ ".jpg").putFile(sampleImage);
      var logoImgUrl=await(await  uploadTask.onComplete).ref.getDownloadURL();
      ImageUrl=logoImgUrl.toString();
      print("logo photo url: "+ ImageUrl);
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
        : new  MaterialApp(
        debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: new AppBar(
              title: new Text('Upload Logo'),
              centerTitle: true,
              backgroundColor: Colors.teal,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) {
                    return View();
                  }));
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
                        SizedBox(height:300,),
                        new Center(
                          child: Text('Select an image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
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
                                 // color: Colors.white,
                                fontFamily:'Pacifico',
                              ),
                            ),
                          ),
                            elevation: 10.0,
                            //splashColor: Colors.black12,
                            color: Colors.teal,
                            onPressed: () {
                              _showDialog1(context);
                            }),

                      ],
                    )
                        : enableUpload(),


                  ],
                ),
              ),
            ),
    );
  }

  Widget enableUpload(){
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
  }
}

