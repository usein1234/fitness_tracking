import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


import '../entity/trainee.dart';
import '../scoped_models/user_model.dart';
import '../scoped_models/main_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  Map<String, dynamic> _signUpData = {
    'fullName': null,
    'email': null,
    'password': null,
    'gender': null,
    'age': 25,
    'weight': null,
    'weightUnit': null,
    'height': null,
    'heightUnit': null,
  };
  int genderValue;
  double _sliderValue = 25.0;
  String _weightValue;
  String _heightValue;
  final GlobalKey<FormState> _signUpTrainee = GlobalKey<FormState>();

  _handleGender(int value) {
    setState(() {
      if (value == 1) {
        genderValue = 1;
        _signUpData['gender'] = 'male';
      } else if (value == 2) {
        genderValue = 2;
        _signUpData['gender'] = 'female';
      }
    });
  }

  _handleAge(double age) {
    setState(() {
      _sliderValue = age;
      _signUpData['age'] = _sliderValue.toInt();
    });
  }

  _handleWeight(String weight) {
    setState(() {
      if (weight == 'kg') {
        _weightValue = 'kg';
        _signUpData['weightUnit'] = _weightValue;
      } else if (weight == 'pounds') {
        _weightValue = 'pounds';
        _signUpData['weightUnit'] = _weightValue;
      }
    });
  }

  _handleHeight(String height) {
    setState(() {
      if (height == 'cm') {
        _heightValue = 'cm';
        _signUpData['heightUnit'] = _heightValue;
      } else if (height == 'inches') {
        _heightValue = 'inches';
        _signUpData['heightUnit'] = _heightValue;
      }
    });
  }

  Container _buildFullNameField() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (String value)  {
          if(value.isEmpty){
            return 'Please enter a name';
          }
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Full name",
            prefixIcon: Icon(
              Icons.account_circle,
              size: 20.0,
            )),
        maxLength: 30,
        onSaved: (nameValue) {
          _signUpData['fullName'] = nameValue;
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
            labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        onSaved: (emailValue) {
          _signUpData['email'] = emailValue;
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
          _signUpData['password'] = passwordValue;
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
            width: 83.0,
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

  Row _buildHeightField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 18.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (String value) {
              if(value.isEmpty) {
                return 'Emty field!';
              }
            },
            decoration: InputDecoration(
              labelText: 'Height',
              labelStyle: TextStyle(color: Colors.white),
            ),
            maxLength: 3,
            keyboardType: TextInputType.number,
            onSaved: (String heightValue) {
              _signUpData['height'] = int.parse(heightValue);
            },
          ),
        ),
        SizedBox(
          width: 55.0,
        ),
        Container(
          padding: EdgeInsets.only(right: 0.0),
          child: Row(
            children: <Widget>[
              Text('Cm'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Radio(
                  activeColor: Colors.greenAccent,
                  value: 'cm',
                  groupValue: _heightValue,
                  onChanged: (height) => _handleHeight(height),
                ),
              ),
              Text('Inches'),
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: Radio(
                  activeColor: Colors.redAccent,
                  value: 'inches',
                  groupValue: _heightValue,
                  onChanged: (height) => _handleHeight(height),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildWeightField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 18.0,
        ),
        Flexible(

          child: TextFormField(
            validator: (String value) {
              if(value.isEmpty) {
                return 'Emty field!';
              }
            },
            decoration: InputDecoration(
              labelText: 'Weight',
              labelStyle: TextStyle(color: Colors.white),
            ),
            maxLength: 3,
            keyboardType: TextInputType.number,
            onSaved: (String weightValue) {
              _signUpData['weight'] = int.parse(weightValue);
            },
          ),
        ),
        SizedBox(
          width: 55.0,
        ),
        Container(
          padding: EdgeInsets.only(right: 0.0),
          child: Row(
            children: <Widget>[
              Text('Kg'),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                child: Radio(
                  activeColor: Colors.greenAccent,
                  value: 'kg',
                  groupValue: _weightValue,
                  onChanged: (String weight) => _handleWeight(weight),
                ),
              ),
              Text('Pounds'),
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: Radio(
                  activeColor: Colors.redAccent,
                  value: 'pounds',
                  groupValue: _weightValue,
                  onChanged: (String weight) => _handleWeight(weight),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/shoe.jpg'),
    );
  }

  testFunction(String name) {
    _signUpData['fullName'] = name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.info),
        title: Text('Trainee info'),
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
                    key: _signUpTrainee,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children: <Widget>[
                          _buildFullNameField(),
                          _buildEmailField(),
                          _buildPasswordField(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _buildAgeField(),
                          _buildGenderField(),
                          SizedBox(
                            height: 5.0,
                          ),
                          _buildWeightField(),
                          _buildHeightField(),
                          SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: RaisedButton(
                              child: Text('Chose your coach'),
                              color: Colors.green,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                  if(!_signUpTrainee.currentState.validate()){
                                    return;
                                  }
//                                _signUpTrainee.currentState.save();
//                                Trainee user = Trainee.setValues(
//                                    _signUpData['id'],
//                                    _signUpData['fullName'],
//                                    _signUpData['email'],
//                                    _signUpData['password'],
//                                    _signUpData['gender'],
//                                    _signUpData['age'],
//                                    _signUpData['height'],
//                                    _signUpData['heightUnit'],
//                                    _signUpData['weight'],
//                                    _signUpData['weightUnit']);
//                                model.registerTrainee(user);
                                print(_signUpData);
                                Navigator.pushReplacementNamed(context, '/signup/trainee/coach');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
