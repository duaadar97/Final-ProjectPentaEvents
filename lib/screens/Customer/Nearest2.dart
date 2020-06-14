import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/screens/Customer/ViewListTileProfile.dart';
import 'package:ajeeb/screens/EventManager/ViewProfile.dart';
import 'package:ajeeb/services/auth.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';









//void main() => runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//    title: 'AppBar Scaffold',
//    theme: ThemeData(
//      primarySwatch: Colors.teal,
//    ),
//    home: GoToNearest()));


class GoToNearest extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _GoToNearestState();
  }

}

class _GoToNearestState extends State<GoToNearest> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("PENTA EVENTS");
  // String searchString;
  String searchStringByArea;
  final AuthService _auth = AuthService();

  navigateToDetail(DocumentSnapshot document) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProfilePage(document: document);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (this.cusIcon.icon == Icons.search) {
                        this.cusIcon = Icon(Icons.arrow_back);
                        this.cusSearchBar = TextField(
                          onChanged: (value) {
                            setState(() {
                              searchStringByArea = value.toLowerCase();
                            });
                          },
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            border: InputBorder.none,
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(25.0))),
                            hintText: "Search",
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        );
                      } else {
                        this.cusIcon = Icon(Icons.search);
                        this.cusSearchBar = Text("PENTA EVENTS");
                        Navigator.of(context).pop();
                      }
                    });
                    // Navigator.of(context).pop();
                  },
                  icon: cusIcon,
                ),
              ],
              title: cusSearchBar,
            ),

//            drawer: new Drawer(
//                child: new ListView(children: <Widget>[
//                  new UserAccountsDrawerHeader(
//                    decoration: BoxDecoration(color: Colors.teal),
////                    accountName: new Text(managerData.orgName),
////                    accountEmail: new Text(managerData.email),
////                    currentAccountPicture: new GestureDetector(
////                      child: new CircleAvatar(
////                        backgroundImage: managerData.logo == 'logo'
////                            ? AssetImage('assets/logo1.jpg')
////                            : NetworkImage(managerData.logo),
////                      ),
////                    ),
//                  ),
//                  new ListTile(
//                    leading: Icon(Icons.phone_in_talk),
//                    title: new Text("Contact us"),
//                    onTap: () {
////                  Navigator.push(context, MaterialPageRoute(builder: (context) {
////                    return Contact();
////                  }));
//                    },
//                  ),
//                  new ListTile(
//                    leading: Icon(Icons.people),
//                    title: new Text("About us"),
//                    onTap: () {
////                  Navigator.push(context, MaterialPageRoute(builder: (context) {
////                    return About();
////                  }));
//                    },
//                  ),
//                  new ListTile(
//                    leading: Icon(Icons.comment),
//                    title: new Text("Reviews"),
//                    onTap: () {
////                  Navigator.push(context, MaterialPageRoute(builder: (context) {
////                    return AddReview();
////                  }));
//                    },
//                  ),
//                  new ListTile(
//                    leading: Icon(Icons.star),
//                    title: new Text("Ratings"),
//                    onTap: () {
////                  Navigator.push(context, MaterialPageRoute(builder: (context) {
////                    return Rate();
////                  }));
//                    },
//                  ),
//                  new ListTile(
//                    leading: Icon(Icons.perm_identity),
//                    title: new Text("View Profile"),
//                    onTap: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context) {
//                        return View();
//                      }));
//                    },
//                  ),
//                  new ListTile(
//                    leading: Icon(Icons.edit),
//                    title: new Text("Edit Credentials"),
//                    onTap: () {
////                  Navigator.push(context, MaterialPageRoute(builder: (context) {
////                    return EditCredentials();
////                  }));
//                    },
//                  ),
//                  new ListTile(
//                      leading: Icon(Icons.lock),
//                      title: new Text("Logout"),
//                      onTap: () async {
//                        await _auth.signOut();
//                      }),
//                ])),

            body: Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/background15.jpg')),
                ),
                child:Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 725.0,
                          child: StreamBuilder<QuerySnapshot>(
                            stream : Firestore.instance
                                .collection("Event_manager")
                                .where("SearchByArea", arrayContains: searchStringByArea)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(child: CircularProgressIndicator());

                                default:
                                  return new ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: snapshot.data.documents
                                        .map((DocumentSnapshot document) {
                                      return new Column(children: <Widget>[
                                        Card(
                                            elevation: 25.0,
                                            margin: new EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 15.0),
                                            child: Container(
                                              //children: <Widget>[]
                                              height: 150.0,

//                                            aw2child: Column(
//                                              children: <Widget>[
                                              //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          height: 500.0,

                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image:
                                                                new CachedNetworkImageProvider(
                                                                  document['Event_Cover'],
                                                                ),
                                                              )),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      navigateToDetail(document);
                                                    },
                                                  ),
                                                  Positioned(
                                                    top: 60.0,
                                                    child: Container(
                                                      height: 80.0,
                                                      width: 80.0,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image:
                                                            new CachedNetworkImageProvider(
                                                              document['Event_Logo'],
                                                            ),
                                                          ),
                                                          border: Border.all(
                                                              color: Colors.white,
                                                              width: 3.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
//
                                            )),
                                        Center(
                                            child: Text(document['Event_orgName'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ))),
                                      ]);
                                    }).toList(),
                                  );
                              }
                            },
                          )))
                ])

            )));




  }
}