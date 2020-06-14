
import 'package:ajeeb/screens/CustEvent.dart';
import 'package:ajeeb/screens/EventManager/EditCredentials.dart';
import 'package:ajeeb/screens/SplashScreen.dart';
import 'package:ajeeb/shared/loading.dart';


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:after_layout/after_layout.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app intro',
      home: HomePage(),
    ));

List<String> imagePath = [
  "assets/c5.jpg",
  "assets/c4.jpg",
  "assets/c1.jpg",
];

List<String> title = ["Welcome", "Browse", "Ready , set..."];
List<String> description = [
  "Discover Event Managers for your perfect events with ",
  "We connect you to your favorite event planners and show you all the best portfolios in one place.",
  "Find the perfect planner for you."
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ContentPage(),
    );
  }
}

class ContentPage extends StatefulWidget {

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentPageState();
  }
}
class _ContentPageState extends State<ContentPage>

    with AfterLayoutMixin<ContentPage>

{

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new CustEvent()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: MySplash()
//      )Center(
//        child: new Text('Loading...'),
//      ),
    );
  }
}


class IntroScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
    child: Container(
        child: Padding(
            padding: EdgeInsets.only(top: 24.0,),
            child: CarouselSlider(
              autoPlay: false,
              enableInfiniteScroll: false,
              initialPage: 0,
              reverse: false,
              viewportFraction: 1.0,
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              height: MediaQuery.of(context).size.height - 10,
              items: [0, 1, 2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          //color: Colors.amber,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/background15.jpg')),
                        ),
                        child: AppIntro(i)
//                    child: Text('text $i',
//                      style: TextStyle(fontSize: 16.0),)
                        );
                  },
                );
              }).toList(),
            ))));
  }
}

class AppIntro extends StatefulWidget {
  int index;
  AppIntro(this.index);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppIntroState();
  }
}

class _AppIntroState extends State<AppIntro> {
  @override
  void initState() {
    super.initState();
    print(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          //color: Colors.cyanAccent,
          child: Stack(children: <Widget>[
            Positioned(
              top: 10,
              left: 24,

              child:Shimmer.fromColors(
                              period: Duration(milliseconds: 1500),
                              baseColor: Colors.black,
                              highlightColor: Colors.tealAccent,
                              //child: Container(
                                //padding: EdgeInsets.all(1.0),
                                child: Text("Penta Events",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily:'Pacifico',
                                      fontWeight: FontWeight.bold,
//                                      shadows: <Shadow>[
//                                        Shadow(
//                                            blurRadius: 18.0,
//                                            color: Colors.black87,
//                                            offset: Offset.fromDirection(120, 12)
//                                        )
//                                      ]
                                  ),
                                ),
                            //  ),
                            )


//              Text(
//                "Penta Events",
//                style: TextStyle(fontSize: 25,
//                  fontWeight: FontWeight.bold,
//                  color: Colors.black
//                ),
//              ),
            ),
            Positioned(
                right: 24,
                top: 12,
                child:
                GestureDetector(
                  onTap: (){
                    if(widget.index == 0 )
                      {
                        IgnorePointer();
                      }
                    if(widget.index==1)
                      {
                        IgnorePointer();
                      }
                  },
                child: new Text(widget.index == 2 ? "DONE" : "SKIP",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily:'Pacifico',
                      color: Colors.teal,
                    ))))
          ])),
      Container(

          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20),
          //height: 550.0,
          height: MediaQuery.of(context).size.height - 190,
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.values(CrossAxisAlignment.start),
              children: <Widget>[
            Image.asset(
              imagePath[widget.index],
              fit: BoxFit.fitHeight,
              height: 410.0,
            ),
            Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(
                  child: new Text(title[widget.index],
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily:'Pacifico',
                        fontWeight: FontWeight.bold,
                      )),
                )),
            Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: new RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontFamily:'Pacifico',
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                            text: description[widget.index],
                          ),
                          new TextSpan(
                              text: widget.index == 0 ? 'Penta Events.' : '',
                              style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Pacifico',
                                //fontFamily: ''
                              )),
//                          new TextSpan(
//                              text: widget.index == 2 ? 'Penta Events.' : '',
//                              style: new TextStyle(
//                                fontWeight: FontWeight.normal,
//                                fontFamily: 'Pacifico',
//                                //fontFamily: ''
//                              ))
                        ])))
          ])),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        // color:Colors.red,
        height: 70,
        child: Stack(children: <Widget>[
          DotsIndicator(widget.index),
          Center(
              child: new Text(widget.index != 2 ? 'SCROLL RIGHT' : '',
                  style: TextStyle(fontSize: 10,
                    fontFamily: 'Pacifico',
                  ))),
          Positioned(
              top: widget.index != 2 ? 36 : 0,
              right: 0,
              child: widget.index != 2
                  ? Image.asset(
                      'assets/arrow.png',
                      width: 30,
                    )
                  : LetsGo())
        ]),
      )
    ]);
  }
}

class DotsIndicator extends StatefulWidget {
  int pageIndex;
  DotsIndicator(this.pageIndex);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DotsIndicatorState();
  }
}

class _DotsIndicatorState extends State<DotsIndicator> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, int index) {
        return Container(
          margin: EdgeInsets.only(right: index != 2 ? 4 : 0),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal),
              color: index == widget.pageIndex ? Colors.teal : Colors.white),
        );
      },
    );
  }
}

class LetsGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          //shape:BoxShape.circle,
         // borderRadius: new BorderRadius.circular(20.0),
          color: Colors.teal,
        ),
        width: 150,
        height: MediaQuery.of(context).size.height,

        child: Stack(children: <Widget>[
          Positioned(
              top: 8,
              left: 18,
              child: Shimmer.fromColors(
                period: Duration(milliseconds: 1500),
                baseColor: Colors.white,
                highlightColor: Colors.tealAccent,
                child: Container(

                    padding: EdgeInsets.all(16.0),
                    child: GestureDetector(

                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CustEvent();
                        }));
                      },

                      child: Text(
                        "LET'S GO!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                            fontStyle: FontStyle.italic,
                            shadows: <Shadow>[
                              Shadow(
                                  blurRadius: 18.0,
                                  color: Colors.black87,
                                  offset: Offset.fromDirection(120, 12))
                            ]),
                      ),
                    )),
              )

//          child: Text("Let'S GO!",
//            style: TextStyle(color:Colors.white),
//          )

              ),
        ]));
  }
}
