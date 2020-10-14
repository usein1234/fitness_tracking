import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import '../scoped_models/user_model.dart';
import '../scoped_models/main_model.dart';
import '../entity/trainee.dart';
import '../entity/coach.dart';

class AuthPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  Map<String, String> _loginData = {
    'email': null,
    'password': null,
    'accountType': null
  };
  String _type = 'trainee';
  final GlobalKey<FormState> _loginFormState = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      image: AssetImage('assets/sunset-run.jpg'),
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-mail',
        labelStyle: TextStyle(color: Colors.white),
        icon: Icon(Icons.account_circle),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter email address';
        }
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value))
          return 'Enter Valid Email';
        else
          return null;
      },
      onSaved: (String email) {
        _loginData['email'] = email.toString();
      },
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Icon(Icons.https),
        labelStyle: TextStyle(color: Colors.white),
      ),
      obscureText: true,
      validator: (String value) {
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if(value.length > 20) {
          return 'Max password characters 20 ';
        }
      },
      onSaved: (String password) {
        _loginData['password'] = password.toString();
      },
    );
  }

  Row _buildGenderField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Coach:'),
        Radio(
          value: 'coach',
          groupValue: _type,
          onChanged: (value) => _handleValue(value),
        ),
        Text('Trainee:'),
        Radio(
            activeColor: Colors.lightGreenAccent,
            value: 'trainee',
            groupValue: _type,
            onChanged: (value) => _handleValue(value)),
      ],
    );
  }

  Container _buildLoginButton(
      Function authenticate, Coach coach, Trainee trainee, Function getCoachData) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0, top: 8.0),
      height: 40.0,
      width: 250.0,
      child: RaisedButton(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 15.0),
          ),
          color: Colors.black54,
          textColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () {
            if (!_loginFormState.currentState.validate()) {
              return;
            }
            _loginFormState.currentState.save();
            _loginData['accountType'] = _type.toString();
            _submitUser(authenticate, coach, trainee, getCoachData);
          }),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Incorrect login data"),
          content: new Text("Your password or email are incorrect!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _submitUser(Function authenticate, Coach coach, Trainee trainee, Function getCoachData) async {
  //  var result = await authenticate(_loginData);
//    if (result) {
//      if (coach.id != null) {
//        Navigator.pushReplacementNamed(context, '/coach');
//      } else if (trainee.id != null) {
//        Navigator.pushReplacementNamed(context, '/trainee');
//      }
//    } else {
//      _showDialog();
//    }
    if(_type == 'coach') {
      Navigator.pushReplacementNamed(context, '/coach');
      getCoachData();
    } else if(_type == 'trainee'){
      Navigator.pushReplacementNamed(context, '/trainee');
    }

//    }
  }

  Container _buildSignUpButtons() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      //height: 40.0,
      // width: 250.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Sign up as Coach', style: TextStyle(fontSize: 15.0)),
            textColor: Colors.blue,
            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup/coach');
            },
          ),
          SizedBox(
            width: 3.0,
          ),
          RaisedButton(
            child: Text('Sign up as Trainee', style: TextStyle(fontSize: 15.0)),
            textColor: Colors.lightGreenAccent,
            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup/trainee');
            },
          ),
        ],
      ),
    );
  }

  void _handleValue(String s) {
    setState(() {
      if (s == 'coach') {
        _type = 'coach';
        _loginData['accountType'] = _type;
      } else if (s == 'trainee') {
        _type = 'trainee';
        _loginData['accountType'] = _type;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: Icon(Icons.account_box),
          title: Text(
            "TrainFit",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(image: _buildBackgroundImage()),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(child: ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return Form(
                  key: _loginFormState,
                  child: Column(
                    children: <Widget>[
//                      Text(
//                        'TrainFit',
//                        style: TextStyle(
//                            fontSize: 35.0,
//                            color: Colors.white,
//                            fontStyle: FontStyle.italic),
//                      ),
                      _buildEmailField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildGenderField(),
                      _buildLoginButton(model.authenticateUser, model.getCoach,
                          model.getTrainee, model.getCoachTrainees),
                      Container(
                        width: 300.0,
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        child: Text(
                          'OR',
                        ),
                      ),
                      _buildSignUpButtons(),
                    ],
                  ),
                );
              })),
            ),
          ),
        ));
  }
}
