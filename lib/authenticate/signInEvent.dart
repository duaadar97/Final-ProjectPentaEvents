
import 'package:ajeeb/authenticate/register_as_customer.dart';
import 'package:ajeeb/authenticate/register_as_event_manager.dart';
import 'package:ajeeb/screens/CustEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:ajeeb/services/auth.dart';
import 'package:ajeeb/shared/constants.dart';
import 'package:ajeeb/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';







//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SignInEvent()));
//}


class SignInEvent extends StatefulWidget {
  final Function toggleView;
  SignInEvent({this.toggleView});

  @override
  _SignInEventState createState() => _SignInEventState();
}

class _SignInEventState extends State<SignInEvent> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';



  TextEditingController emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()

        : MaterialApp(
        debugShowCheckedModeBanner: false,
    home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          elevation: 0.0,
          title: Text('Sign in to Penta Events'),
//            leading: IconButton(
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              icon: Icon(Icons.arrow_back),
//            )
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CustEvent();
              }));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body:

         Container(
          decoration: new BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/backgorund3.jpg')),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      width: 350.0,
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailEditingController,
                        autofocus: false,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(
                              color: Colors.teal,
                              //Color of the border
                              style: BorderStyle.solid,
                              //Style of the border
                              width: 2.5, //width of the border
                            ),
                          ),
                          labelText: "Email",
                          hintText: 'Email...',
                          icon: new Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),),
//                decoration: textInputDecoration.copyWith(hintText: 'Email...'),
                        validator: (val) =>
                        val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 350,
                      child: TextFormField(
                        maxLines: 1,
                        obscureText: true,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(1.0)),
                            borderSide: BorderSide(
                              color: Colors.teal,
                              //Color of the border
                              style: BorderStyle.solid,
                              //Style of the border
                              width: 2.5, //width of the border
                            ),
                          ),
                          labelText: "Password",
                          hintText: 'Password...',
                          icon: new Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter a Password';
                          } else if (val.length < 6) {
                            return 'Enter a password 6+ chars long';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.teal,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),

                        elevation: 10.0,

                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        //color: Colors.teal,
                        // textColor: Colors.white,

                        onPressed: () async {
                          if (_formKey.currentState.validate())
                          {
                            setState(() => loading = true);
                            dynamic result =
                            await _auth.signInWithEmailAndPassword(
                                email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Incorrect Email/Password';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style:
                      TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
//                    Align(
//                        alignment: Alignment.bottomCenter,
//                        child: Container(
//                            margin: EdgeInsets.all(2.0),
//                            height: 25.0,
//                            width: 200.0,
//                            child: Column(
//                                children: <Widget>[
//                                  Text('Dont have an account?',
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        fontSize: 20.0,
//                                        color: Colors.teal),
//                                  ),
//                                  RaisedButton(
//                                    onPressed: () {
//                                      widget.toggleView();
//                                      //SignUpAs(context);
//                                    },
//                                    color: Colors.teal,
//                                    shape: new RoundedRectangleBorder(
//                                      borderRadius: new BorderRadius.circular(15.0),
//                                    ),
//                                    textColor: Colors.white,
//                                    child: const Text('Sign Up!',
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold,
//                                          fontSize: 20.0,
//                                          color: Colors.white),
//                                    ),
//                                    elevation: 10.0,
//
//
//                                  ),
//                                ]))
//                    ),

                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          height: 50.0,
                          width: 200.0,
                          child: RaisedButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            color: Colors.teal,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            textColor: Colors.white,
                            child: const Text('Dont have an account? '
                                           'Sign Up!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white),
                            ),
                            elevation: 10.0,


                          ),
                        )
                    ),

                  ],
                ),
              ),
            ),
          ),
        )
        ));

  }
}


