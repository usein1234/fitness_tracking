import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/user_model.dart';
import '../scoped_models/main_model.dart';

import '../entity/coach.dart';

class SignUpCoach extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpCoachState();
  }
}

class _SignUpCoachState extends State<SignUpCoach> {
  Map<String, dynamic> _signUpCoach = {
    'id': null,
    'fullName': null,
    'email': null,
    'password': null,
    'age': null,
    'gender': null,
    'traineeNumber': null,
    'experience': null,
    'area': 'running',
  };
  int genderValue;
  double _sliderValue = 25.0;
  double _sliderNumberTrainee = 5.0;
  String _currentArea = 'running';
  final GlobalKey<FormState> _signUpCoachKey = GlobalKey<FormState>();

  _handleAge(double age) {
    setState(() {
      _sliderValue = age;
      _signUpCoach['age'] = _sliderValue.toInt();
    });
  }

  _handleTraineeNumber(double number) {
    setState(() {
      _sliderNumberTrainee = number;
      _signUpCoach['traineeNumber'] = _sliderNumberTrainee.toInt();
    });
  }

  _handleGender(int value) {
    setState(() {
      if (value == 1) {
        genderValue = 1;
        _signUpCoach['gender'] = 'male';
      } else if (value == 2) {
        genderValue = 2;
        _signUpCoach['gender'] = 'female';
      }
    });
  }

  Container _buildFullNameField() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Full name",
            prefixIcon: Icon(
              Icons.account_circle,
              size: 20.0,
            )),
        maxLength: 30,
        onSaved: (nameValue) {
          _signUpCoach['fullName'] = nameValue;
        },
      ),
    );
  }

  Container _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (String value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value))
            return 'Enter Valid Email';
          else
            return null;
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.email,
              size: 20.0,
            ),


            labelText: 'Email',),
        keyboardType: TextInputType.emailAddress,
        onSaved: (emailValue) {
          _signUpCoach['email'] = emailValue;
        },
      ),
    );
  }

  Container _buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (String value) {
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          if(value.length > 20) {
            return 'Max password characters 20 ';
          }
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: 'Password',
            prefixIcon: Icon(
              Icons.security,
              size: 20.0,
            )),
        obscureText: true,
        onSaved: (passwordValue) {
          _signUpCoach['password'] = passwordValue;
        },
      ),
    );
  }

  Container _buildAgeField() {
    return Container(
      margin: EdgeInsets.only(left: 18.0),
      child: Row(
        children: <Widget>[
          Text(
            'Age: ${_sliderValue.toInt()}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            width: 85.0,
          ),
          Slider(
            divisions: 50,
            activeColor: Colors.lightBlue,
            min: 16.0,
            max: 60.0,
            onChanged: (newRating) => _handleAge(newRating),
            value: _sliderValue,
          ),
        ],
      ),
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      image: AssetImage('assets/coach.png'),
    );
  }

  Container _buildGenderField() {
    return Container(
      margin: EdgeInsets.only(left: 18.0, right: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Gender:',
            style: TextStyle(fontSize: 16.0),
          ),
          Row(
            children: <Widget>[
              Text('Male'),
              Radio(
                activeColor: Colors.greenAccent,
                value: 1,
                groupValue: genderValue,
                onChanged: (value) => _handleGender(value),
              ),
              Text('Female'),
              Radio(
                activeColor: Colors.red,
                value: 2,
                groupValue: genderValue,
                onChanged: (value) => _handleGender(value),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildExperienceField() {
    return Container(
      margin: EdgeInsets.only(left: 18.0, right: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Experience:',
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(
            width: 80.0,
          ),
          Flexible(
            child: TextFormField(
              validator: (String value) {
                if(value.isEmpty) {
                  return 'Fill the field';
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Years',
              ),
              onSaved: (String value) {
                _signUpCoach['experience'] = int.parse(value);
              },
            ),
          )
        ],
      ),
    );
  }

  Container _buildNumberOfTraineeField() {
    return Container(
      margin: EdgeInsets.only(left: 18.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Trainees: ${_sliderNumberTrainee.toInt()}',
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(
            width: 48.0,
          ),
          Slider(
            activeColor: Colors.lightGreen,
            min: 5.0,
            max: 12.0,
            onChanged: (ss) => _handleTraineeNumber(ss),
            value: _sliderNumberTrainee,
          ),
        ],
      ),
    );
  }

  Container _buildAreaField() {
    return Container(
      margin: EdgeInsets.only(left: 18.0, right: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Area of activity:', style: TextStyle(fontSize: 15.0)),
          DropdownButton<String>(
            value: _currentArea,
            items: <String>['running', 'swimming', 'hiking', 'cycling']
                .map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _currentArea = value;
                _signUpCoach['area'] = _currentArea;
              });
            },
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.music_note),
                    title: new Text('Music'),
                    onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach info'),
        leading: Icon(Icons.accessibility),
      ),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return Form(
                  key: _signUpCoachKey,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Column(
                      children: <Widget>[
                        _buildFullNameField(),
                        _buildEmailField(),
                        _buildPasswordField(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _buildAgeField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        _buildGenderField(),
                        SizedBox(
                          height: 5.0,
                        ),
                        _buildExperienceField(),
                        _buildAreaField(),
                        _buildNumberOfTraineeField(),
                        Container(
                          margin: EdgeInsets.only(top: 2.0, bottom: 6.0),
                          width: 220.0,
                          child: RaisedButton(
                              child: Text('Create account'),
                              onPressed: () {
                                if(!_signUpCoachKey.currentState.validate()){
                                  return;
                                }
                                _signUpCoachKey.currentState.save();
                                print(_signUpCoach);
                                Coach user = new Coach.setValues(
                                    _signUpCoach['id'],
                                    _signUpCoach['fullName'],
                                    _signUpCoach['email'],
                                    _signUpCoach['password'],
                                    _signUpCoach['gender'],
                                    _signUpCoach['age'],
                                    _signUpCoach['experience'],
                                    _signUpCoach['area'],
                                    _signUpCoach['traineeNumber']);
                                model.registerCoach(user);
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
