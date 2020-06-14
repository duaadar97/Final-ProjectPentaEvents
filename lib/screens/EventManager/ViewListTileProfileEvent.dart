import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ajeeb/screens/EventManager/homeEvent.dart';

import '../Categories.dart';
import '../Services.dart';
import '../Themes.dart';

//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage()));
//}
class ProfilePage extends StatefulWidget {

  final DocumentSnapshot document;
  ProfilePage({this.document});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot document;


  List<Widget> _buildGridTiles(List portfolio) {

    List<Container> containers = new List<Container>.generate(portfolio.length,
            (int index) {
          return new Container(
            child: GestureDetector(
              child: Image(
                image: NetworkImage(portfolio[index],),
                fit: BoxFit.fill,
              ),
              onTap: (){
                _showImage(context,portfolio[index]);
              },
            ),
          );
        });
    return containers;
  }

  Widget _showImage(BuildContext context,String image){
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Upload Image'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0.0,
      ),
      body: Container(
        child: Image(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: new AppBar(
              title: new Text('Penta Events'),
              backgroundColor: Colors.teal,

            ),
            drawer: new Drawer(
              child: new ListView(
//                children: snapshot.data.documents
//                    .map((DocumentSnapshot document)
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.teal),
                    accountName: new Text(widget.document.data['Event_orgName']),
                    accountEmail: new Text(widget.document.data['Event_email']),
//                    currentAccountPicture: new GestureDetector(
//                      child: new CircleAvatar(
//                        backgroundImage: AssetImage('assets/cust.jpg'),
//                      ),
//                    ),
                  ),



                  new ListTile(
                    leading: new Icon(Icons.category),
                    title: new Text('Categories'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MyCategory(this.document.data["Event_id"]);
                      }));
                    },
                  ),
                  //      new ListTile(
                  //        leading: new Icon(Icons.packages),
                  //        title: new Text('Packages'),
                  //      ),
                  new ListTile(
                    leading: new Icon(Icons.color_lens),
                    title: new Text('Themes'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MyThemes(this.document.data["Event_id"]);
                      }));
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.calendar_today),
                    title: new Text('Services'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Services(this.document.data["Event_id"]);
                      }));
                    },
                  ),
                ],
              ),
            ),


            body:  Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/background15.jpg')),
                ),

                child:

                new ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      new Column(
                        children: <Widget>[

                          Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        height: 230.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                            new CachedNetworkImageProvider(
                                              widget.document.data['Event_Cover'],
                                            ),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                              Positioned(
                                top: 130.0,
                                child: Container(
                                  height: 95.0,
                                  width: 95.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                        new CachedNetworkImageProvider(
                                          widget.document.data['Event_Logo'],
                                        ),),
                                      border:
                                      Border.all(color: Colors.white, width: 3.0)),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(widget.document.data['Event_orgName'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 25.0,color: Colors.white))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_on,
                                      size: 20.0,),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(widget.document.data['Event_address'],
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.phone,size: 20.0,),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(widget.document.data['Event_phone'],
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.mail,size: 20.0,),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(widget.document.data['Event_email'],
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,size: 20.0,),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text('9:00 AM - 5:00 PM',
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_city,size: 20.0,),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(widget.document.data['Event_serving_areas'],
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 12.0,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(7.0),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.all(1.0),
                                      alignment: Alignment.topLeft,
                                      child: Text("Description",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                          ))),

                                  Container(
                                      margin: EdgeInsets.all(1.0),
                                      alignment: Alignment.topLeft,
                                      child:widget.document.data['Description']==null?
                                      Text('No Description!',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontStyle: FontStyle.italic
                                        ),
                                      )
                                          :Text(widget.document.data['Description'],
                                        style: TextStyle(
                                          fontSize: 16.0,

                                        ),
                                      )
                                  ),
                                ],
                              )
                          ),
                          Container(
                            height: 12.0,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(7.0),
                            //alignment: Alignment.topLeft,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Porfolio",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(1.0),
                                  alignment: Alignment.topLeft,
                                  child: widget.document.data['Event_portfolio'].length==0? Text(
                                    "No Portfolio Yet! ",
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontStyle: FontStyle.italic
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ) :     Center(
                                    child: Container(
                                      //height: 300.0,
                                      child: new GridView.extent(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        maxCrossAxisExtent: 150.0,
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 5.0,
                                        padding: const EdgeInsets.all(5.0),
                                        children: _buildGridTiles(widget.document.data['Event_portfolio']),//Where is this function ?
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            height: 15.0,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(7.0),

                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Customers",
                                    style: TextStyle(fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(1.0),
                                  alignment: Alignment.topLeft,
                                  child: widget.document.data['Event_customers'].length==0?
                                  Text("No Customers Yet!",
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontStyle: FontStyle.italic
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ):Container(
                                    child: new ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:widget.document.data['Event_customers'].length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return new Column(
                                          children: <Widget>[
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SizedBox(width: 5.0,),
                                                Icon(Icons.arrow_right),
                                                Text(widget.document.data['Event_customers'][index],
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    //fontWeight: FontWeight.bold
                                                  ),),
                                              ],
                                            ),

                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),





                        ],)
                    ]
                )
            )
        ));
  }
}