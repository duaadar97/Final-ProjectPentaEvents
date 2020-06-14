import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

void main() => runApp(Rate());

class Rate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
            appBar: AppBar(
              title:
              Text('Ratings'),
              backgroundColor: Colors.teal,

              leading:IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/background15.jpg')),
                ),
                child: Center(
                    child: RatingBar()
                ))
        )
    );
  }
}

class RatingBar extends StatefulWidget {

  RatingBarWidget createState() => RatingBarWidget();

}

class RatingBarWidget extends State {

  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[

                Container(
                  alignment:Alignment.center,
                  //margin: EdgeInsets.only(top:50.0),
                  child: Center(
                      child: Text('Please Rate Here:',
                          style: TextStyle(fontSize: 20))
                  ),
                ),
                Container(
                  alignment:Alignment.center,
                  margin: EdgeInsets.only(top:25.0),
                  child: SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (value) {
                      setState(() {
                        rating = value ;
                      });
                    },
                    starCount: 5,
                    rating: rating,
                    size: 50.0,
                    color: Colors.teal,
                    borderColor: Colors.white,
                    spacing:0.0,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Rating = '+' $rating',
                        style: TextStyle(fontSize: 18)
                    )
                ),

              ],
            ),
          ));
  }
}

