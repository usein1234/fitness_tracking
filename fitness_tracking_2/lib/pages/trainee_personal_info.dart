import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../scoped_models/main_model.dart';
import '../entity/trainee.dart';

class TraineePersonalInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TraineePersonalInfoState();
  }
}

class _TraineePersonalInfoState extends State<TraineePersonalInfo> {
  GlobalKey<FormState> _updateInfo = GlobalKey<FormState>();
  final Map<String, dynamic> _personUpdateInfo = {
    'trainee_id': 1,
    'name': null,
    'age': null,
    'weight': null,
    'weight_unit': 'kg',
    'height': null,
    'height_unit': 'cm',
  };
  String _heightValue = 'cm';
  String _weightValue = 'kg';

  _handleWeight(String weight) {
    setState(() {
      if (weight == 'kg') {
        _weightValue = 'kg';
        _personUpdateInfo['weight_unit'] = _weightValue;
      } else if (weight == 'pounds') {
        _weightValue = 'pounds';
        _personUpdateInfo['weight_unit'] = _weightValue;
      }
    });
  }

  _handleHeight(String height) {
    setState(() {
      if (height == 'cm') {
        _heightValue = 'cm';
        _personUpdateInfo['height_unit'] = _heightValue;
      } else if (height == 'inches') {
        _heightValue = 'inches';
        _personUpdateInfo['height_unit'] = _heightValue;
      }
    });
  }

  _updateTrainee(Function update, Trainee user) async {
    var c = await update(user);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: Text('Edit personal info'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Chose'),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home page'),
              onTap: () => Navigator.pushReplacementNamed(context, '/trainee'),
            ),
            ListTile(
              leading: Icon(Icons.person_pin),
              title: Text('Coach info'),
              onTap: () => Navigator.pushNamed(context, '/trainee/coach/info'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ],
        ),
      ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        decoration: BoxDecoration(
            color: Colors.black12,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.green,
                Colors.black45,
              ],
            ),
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black45, width: 2.0)),
        padding: EdgeInsets.only(top: 70.0, right: 6.0, left: 6.0),
        child: SingleChildScrollView(
          child: ScopedModelDescendant(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Container(
              decoration: BoxDecoration( color: Colors.green[800],borderRadius: BorderRadius.circular(5.0)),
              child: Form(
                key: _updateInfo,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            onSaved: (String value) {
                              _personUpdateInfo['name'] = value;
                            },
                            initialValue: model.authenticatedTrainee.fullName,
                            decoration: InputDecoration(
                                labelText: 'Full name',
                                icon: Icon(Icons.person)),
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            onSaved: (String value) {
                              _personUpdateInfo['age'] = int.parse(value);
                            },
                            initialValue:
                                model.authenticatedTrainee.age.toString(),
                            decoration: InputDecoration(
                                labelText: 'Age', icon: Icon(Icons.cake)),
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            onSaved: (String value) {
                              _personUpdateInfo['height'] = int.parse(value);
                            },
                            initialValue:
                                model.authenticatedTrainee.getHeight.toString(),
                            decoration: InputDecoration(
                                labelText: 'Height',
                                icon: Icon(FontAwesomeIcons.textHeight)),
                          ),
                        ),
                        SizedBox(
                          width: 70.0,
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
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            onSaved: (String value) {
                              _personUpdateInfo['weight'] = int.parse(value);
                            },
                            initialValue:
                                model.authenticatedTrainee.getWeight.toString(),
                            decoration: InputDecoration(
                                labelText: 'Weight',
                                icon: Icon(FontAwesomeIcons.weight)),
                          ),
                        ),
                        SizedBox(
                          width: 70.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 0.0),
                          child: Row(
                            children: <Widget>[
                              Text('Kg'),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Radio(
                                  activeColor: Colors.greenAccent,
                                  value: 'kg',
                                  groupValue: _weightValue,
                                  onChanged: (String weight) =>
                                      _handleWeight(weight),
                                ),
                              ),
                              Text('Pound'),
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Radio(
                                  activeColor: Colors.redAccent,
                                  value: 'pounds',
                                  groupValue: _weightValue,
                                  onChanged: (String weight) =>
                                      _handleWeight(weight),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: deviceWidth * 0.8,
                          child: RaisedButton(
                            color: Colors.black38,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            onPressed: () {
                              _updateInfo.currentState.save();
                              print(_personUpdateInfo);
                              Trainee updateTrainee = new Trainee();
                              updateTrainee.idValue =
                                  _personUpdateInfo['trainee_id'];
                              updateTrainee.fullNameValue =
                                  _personUpdateInfo['name'];
                              updateTrainee.age = _personUpdateInfo['age'];
                              updateTrainee.weightValue =
                                  _personUpdateInfo['weight'];
                              updateTrainee.weightUnitValue =
                                  _personUpdateInfo['weight_unit'];
                              updateTrainee.heightValue =
                                  _personUpdateInfo['height'];
                              updateTrainee.heightUnitValue =
                                  _personUpdateInfo['height_unit'];
                              _updateTrainee(
                                  model.updateTrainee, updateTrainee);
                            },
                            child: Text(
                              'Update data',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: deviceWidth * 0.8,
                          child: RaisedButton(
                            color: Colors.black54,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () => model.deleteTrainee(14),
                            child: Text(
                              'Delete account',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
