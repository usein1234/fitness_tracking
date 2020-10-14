import 'dart:core';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped_models/main_model.dart';
import './pages/auth.dart';
import './pages/sign_up_trainee.dart';
import './pages/sign_up_trainee_2.dart';
import './pages/home_trainee.dart';
import './pages/sign_up_coach.dart';
import './pages/home_coach.dart';
import './pages/trainee_stat.dart';
import './pages/trainee_steps_details.dart';
import './pages/trainee_meters_details.dart';
import './pages/trainee_calories_details.dart';
import './pages/trainee_personal_info.dart';
import './pages/trainee_coach_info.dart';
import './pages/coach_selection_page.dart';
import 'bluetooth.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _FlutterBlueAppState createState() => new _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'DroidSans', brightness: Brightness.dark),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/trainee': (BuildContext context) => HomeTraineePage(),
          '/trainee/stat': (BuildContext context) => TraineeStatPage(),
          '/trainee/info': (BuildContext context) => TraineePersonalInfo(),
          '/trainee/coach/info': (BuildContext context) => TraineeCoachInfo(),
          '/trainee/coach/chose': (BuildContext context) => CoachSelectionPage(),
          '/trainee/stat/steps': (BuildContext context) => TraineeStepsDetails(),
          '/trainee/stat/meters': (BuildContext context) => TraineeMetersDetails(),
          '/trainee/stat/calories': (BuildContext context) => TraineeCaloriesDetails(),
          '/coach': (BuildContext context) => HomeCoachPage(),
          '/signup/trainee': (BuildContext context) => SignUpPage(),
          '/signup/coach': (BuildContext context) => SignUpCoach(),
          '/signup/trainee/coach': (BuildContext context) => CoachSelectPage(),
          '/bluetooth': (BuildContext context) => BluetoothPageResults(),
        },
      ),
    );
  }
}
