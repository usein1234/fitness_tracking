import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../scoped_models/main_model.dart';
import '../entity/goal.dart';

class GoalsCreatePage extends StatefulWidget {
  final int index;
  final String name;

  GoalsCreatePage(this.index, this.name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GoalsCreatePageState();
  }
}

class _GoalsCreatePageState extends State<GoalsCreatePage> {
  GlobalKey<FormState> _createGoal = GlobalKey<FormState>();
  final Map<String, dynamic> _goalData = {
    'title': null,
    'distance': null,
    'duration_hour': 0,
    'duration_minute': 0,
    'first_date': null,
    'second_date': null,
    'description': null,
  };

  Widget date = new Container();

  Row _buildDistanceField(Function handleValue, String distanceValue) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            onSaved: (String value) {
              _goalData['distance'] = int.parse(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Distance', icon: Icon(FontAwesomeIcons.running)),
          ),
        ),
        SizedBox(
          width: 30.0,
        ),
        Text('Km'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Radio(
            activeColor: Colors.greenAccent,
            value: 'km',
            groupValue: distanceValue,
            onChanged: (kmValue) => handleValue(kmValue),
          ),
        ),
        Text('Meters'),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: Radio(
            activeColor: Colors.redAccent,
            value: 'meter',
            groupValue: distanceValue,
            onChanged: (meterValue) => handleValue(meterValue),
          ),
        ),
      ],
    );
  }

  Row _buildTimeField() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            onSaved: (String value) {
              print('aaaaaaasdasad: $value');
              _goalData['duration_hour'] = int.parse(value);
            },
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
                labelText: 'hh', icon: Icon(FontAwesomeIcons.hourglassStart)),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '/',
          style: TextStyle(fontSize: 30.0),
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            onSaved: (String value) {
              _goalData['duration_minute'] = int.parse(value);
            },
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: 'mm',
            ),
          ),
        ),
      ],
    );
  }

  _submitForm(Function createGoal, Goal goalData, BuildContext context, String date) async {
    var c = await createGoal(goalData, date);
    if(c) {
      print('Goal created with success');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Set goal for ${widget.name}'),
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return Center(
          child: SingleChildScrollView(
            child: Container(
              width: deviceWidth * 0.95,
              padding: EdgeInsets.only(right: 10.0, bottom: 25.0),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Form(
                key: _createGoal,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: TextFormField(
                            onSaved: (String value) {
                              _goalData['title'] = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Goal title',
                                icon: Icon(FontAwesomeIcons.inbox)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    _buildDistanceField(model.handleValue, model.distanceValue),
                    SizedBox(
                      height: 3.0,
                    ),
                    _buildTimeField(),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Icon(
                          Icons.date_range,
                          size: 28.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        MaterialButton(
                          color: Colors.lightGreen,
                          onPressed: () async {
                            var formatter =   new DateFormat('yyyy-MM-dd');
                              var picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now().subtract(Duration(days: 1)),
                                lastDate: DateTime(2030),
                              );


                              String formattedDate =
                                  formatter.format(picked);
                              date = Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Date: $formattedDate',
                                  ),
                                ],
                              );
                              _goalData['first_date'] = formattedDate;
                              setState(() {});

                          },
                          child: new Text(
                            "Pick date",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    date,
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Flexible(
                          child: TextFormField(
                            onSaved: (String value) {
                              _goalData['description'] = value;
                            },
                            maxLines: 4,
                            decoration: InputDecoration(
                              icon: Icon(Icons.description),
                              labelText: 'Description',
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Save'),
                          onPressed: () {
                            _createGoal.currentState.save();
                            var time =  Duration(
                                hours: _goalData['duration_hour'],
                                minutes: _goalData['duration_minute']).inMilliseconds;
                            print('time');
                            print(_goalData['duration_hour']);
                            print(_goalData['duration_minute']);
                            print(time);


                            Goal createGoal = new Goal(
                              title: _goalData['title'],
                              description: _goalData['description'],
                              coachId: 1,
                              distance: _goalData['distance'],
                              distanceUnit: model.distanceValue,
                              traineeId: widget.index +1,
                              goalDuration: time,
                              rangeFirstDate: _goalData['first_date'],
                            );
                            print(_goalData);
                            print(createGoal.traineeId);
                            print(createGoal.coachId);
                            print(createGoal.description);
                            print(createGoal.title);
                            print(createGoal.distance);
                            print(createGoal.distanceUnit);
                            print(createGoal.goalDuration);
                            print(createGoal.rangeFirstDate);
                            _submitForm(model.createGoal, createGoal, context, model.yearMonthDayDate);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
