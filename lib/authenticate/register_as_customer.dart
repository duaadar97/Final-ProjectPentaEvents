import 'package:ajeeb/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ajeeb/services/auth.dart';

import 'package:ajeeb/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';


//void main() {
//  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: RegisterAsCustomer()));
//}

class RegisterAsCustomer extends StatefulWidget {
  final Function toggleView1;
  RegisterAsCustomer({this.toggleView1});

  @override
  _RegisterAsCustomerState createState() => _RegisterAsCustomerState();
}

class _RegisterAsCustomerState extends State<RegisterAsCustomer> {
  TextEditingController _addNameController;
  TextEditingController _addEmailController;
  TextEditingController _addPasswordController;
  TextEditingController _addCnicController;
  TextEditingController _addPhoneController;
  TextEditingController _addAddressController;

  //String name,email,password;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _addNameController = TextEditingController();
    _addEmailController = TextEditingController();
    _addPasswordController = TextEditingController();
    _addCnicController = TextEditingController();
    _addPhoneController = TextEditingController();
    _addAddressController = TextEditingController();
  }

  // text field state
  String email = '';
  String password = '';
  String username = '';
  String address = '';
  String cnic = '';
  String phone_no = '';
  String profilePic = '';

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  FocusNode _phoneNoFocusNode = FocusNode();
  FocusNode _cnicFocusNode = FocusNode();

  //FocusNode _profilePicFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.teal[400],
              elevation: 0.0,
              title: Text('Sign up to Penta Events'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                  onPressed: () => widget.toggleView1(),
                ),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 652.0,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage('assets/background15.jpg')),
                  ),
                  child: Form(
                    key: _formKey,

                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 150),
                        child: Row(children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              margin: EdgeInsets.only(left: 20),

                              child: Column(children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _addNameController,
                                  focusNode: _usernameFocusNode,
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
                                    labelText: "Username",
                                    hintText: "Morgan",
                                    icon: new Icon(
                                      Icons.book,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  //textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,

                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    //Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                    Pattern pattern = r'^[a-z0-9_-]{3,15}$';
                                    RegExp regex = new RegExp(pattern);
                                    if (val.isEmpty) {
                                      return 'Please enter username';
                                    } else if (!regex.hasMatch(val))
                                      return 'Invalid username';
                                    else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => username = val);
                                  },
                                  //onSaved: (name) => username = ,
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context, _usernameFocusNode,
                                        _emailFocusNode);
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _addEmailController,

                                  focusNode: _emailFocusNode,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
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
                                    hintText: 'Email...',
                                    labelText: "Email",
                                    icon: new Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  // decoration: textInputDecoration.copyWith(hintText: 'email'),
                                  //validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter an email';
                                    } else if (!EmailValidator.validate(
                                        email, true)) {
                                      return 'It is not a valid email';
                                    } else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context, _emailFocusNode,
                                        _passwordFocusNode);
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _addPasswordController,
                                  focusNode: _passwordFocusNode,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,

                                  textInputAction: TextInputAction.next,

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
                                    hintText: 'Password...',
                                    labelText: "Password",
                                    icon: new Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  // decoration: textInputDecoration.copyWith(hintText: 'password'),
                                  //obscureText: true,
                                  validator: (val) {
                                    Pattern pattern =
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                    //r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                                    RegExp regex = new RegExp(pattern);
                                    if (val.isEmpty) {
                                      return 'Please enter a Password';
                                    } else if (val.length < 6) {
                                      return 'Enter a password 6+ chars long';
                                    } else {
                                      if (!regex.hasMatch(val)) {
                                        return 'Invalid password';
                                      } else
                                        return null;
                                    }
                                    //return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                              ])),

                          Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              margin: EdgeInsets.only(left: 20),
//                        child: Form(
//                            key: _formKey,
                              child: Column(children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _addCnicController,
                                  focusNode: _cnicFocusNode,
                                  autofocus: true,
                                  //textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
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
                                    icon: new Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                    ),
                                    labelText: "CNIC",
                                    hintText: "35206-3253215-3",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    Pattern pattern =
                                        r'^[0-9+]{5}-[0-9+]{7}-[0-9]{1}$';
                                    RegExp regex = new RegExp(pattern);

                                    if (val.isEmpty)
                                      return 'please enter cnic';
                                    else if (!regex.hasMatch(val))
                                      return 'please enter a valid cnic';
                                    else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => cnic = val);
                                  },
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(
                                        context, _cnicFocusNode, _emailFocusNode);
                                  },
                                ),


                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _addPhoneController,
                                  focusNode: _phoneNoFocusNode,
                                  autofocus: true,
                                  //textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
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
                                    icon: new Icon(
                                      Icons.phone_android,
                                      color: Colors.white,
                                    ),
                                    labelText: "Phone No",
                                    hintText: "0321-4323644",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    Pattern pattern =
                                        r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';
                                    RegExp regex = new RegExp(pattern);
                                    if (val.isEmpty)
                                      return 'please enter phone no';
                                    else if (!regex.hasMatch(val))
                                      return 'please enter a valid phone no';
                                    else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => phone_no = val);
                                  },
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context, _phoneNoFocusNode,
                                        _emailFocusNode);
                                  },
                                ),



                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _addAddressController,
                                  focusNode: _addressFocusNode,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
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
                                    icon: new Icon(
                                      Icons.add_location,
                                      color: Colors.white,
                                    ),
                                    //contentPadding: EdgeInsets.only(top: 40.0,left: 10),
                                    labelText: "Address",
                                    hintText: "Address...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  validator: (name) {
                                    Pattern pattern =
                                        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(name))
                                      return 'please enter a valid address';
                                    else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => address = val);
                                  },
                                  onFieldSubmitted: (_) {
                                    fieldFocusChange(context, _addressFocusNode,
                                        _emailFocusNode);
                                  },
                                ),
                              ])
                          )]
                        ),),





                      SizedBox(height: 120.0),
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

                          child:Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                fontFamily:'Pacifico',
                                color: Colors.white),
                          ),
                          elevation: 10.0,
                          //splashColor: Colors.black12,
                          color: Colors.teal,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .registerUserWithEmailAndPassword(email, password);
//                                dynamic result= FirebaseAuth.instance.createUserWithEmailAndPassword
//                                  (email: email, password: password);
////                                    .then((signedInUser){
////                                  UserManagement().storeNewUser(signedInUser,context);
////                                })
//                                ;

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please supply a valid email';
                                });
                              }


                              else {
                                User().addToDatabase(
                                    _addNameController.text,
                                    _addEmailController.text,
                                    _addPasswordController.text,
                                    _addCnicController.text,
                                    _addPhoneController.text,
                                    _addAddressController.text
                                );
                                return toastMessage(
                                    "Username : $username\n\n Email : $email\n\n Password : $password");
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      )
                    ]),
                  ),
                ),
              ),
            )
        ));

  }
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

