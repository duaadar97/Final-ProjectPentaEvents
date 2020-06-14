import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
      home:AddReview()
  ));
}

class AddReview extends StatefulWidget{
  @override
  MyApp1 createState()=> new MyApp1();
}
class MyApp1 extends State<AddReview> {
  // This widget is the root of your application.
  final TextEditingController controller= new TextEditingController();
  String results="";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(appBar: AppBar(title: Text('Reviews'),
        backgroundColor: Colors.teal,
        leading:IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
          body:
          Container (
            decoration: new BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background15.jpg')),
            ),
            //margin: EdgeInsets.only(top:30.0,left:10,right:10),
            child:Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(left:10,right:10),
                child: TextField(
                    decoration: InputDecoration(hintText: 'Add your review here'),
                    onSubmitted: (String str){
                      setState(() {
                        results=results+"\n"+str;
                      });

                      controller.text="";
                    },
                    textAlign: TextAlign.left,

                    controller: controller
                ),
              ),
              Container(

              child: Text(results,

              style: TextStyle(
                  fontSize: 15.0,
              ),textAlign: TextAlign.left
              ),
                margin:EdgeInsets.all(6.0),
              ),
              Container(
                  margin:EdgeInsets.all(6.0),
                  child:Text('Greatly inspired by your application.Keep it up.',style: TextStyle(
                    fontSize: 15.0
                  ),textAlign: TextAlign.left)),
              Container(
                margin:EdgeInsets.all(6.0),
                child:Text('Hats off to you guyz.Keep advancing.',
                    style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left),)
            ])
            ,)
      ),
    );

  }
}