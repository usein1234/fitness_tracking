import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import '../entity/time_series.dart';

var urlEmulator = 'http://10.0.2.2:3000';
var urlAndroidDevice = 'http://localhost:3000';

DateTime labelDate = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
var formatterMonth = new DateFormat('yyyy-MM');
String formattedDate = formatter.format(labelDate);
String formattedMonth = formatterMonth.format(labelDate);

class ActivityDataStatisticsModel extends Model {
  Duration walking = new Duration();
  Duration running = new Duration();
  Duration cycling = new Duration();
  Duration activityTime = new Duration();
  int walkingTime = 0;
  int runningTime = 0;
  int cyclingTime = 0;
  int activity = 0;
  List<TimeSeriesSteps> chartData = [];
  List<TimeSeriesSteps> chartMetersData = [];
  List<TimeSeriesCalories> chartCaloriesData = [];
  List<TimeSeriesSteps> chartDataMonth = [];
  List<TimeSeriesSteps> chartMetersDataMonth = [];
  List<TimeSeriesCalories> chartCaloriesDataMonth = [];
  int statusPage = 0;
  int statusPage2 = 0;
  int statusPage3 = 0;
  int sumSteps = 0;
  int sumMeters = 0;
  double sumCalories = 0.0;
  bool stepReady = false;
  int max_steps = 0;
  int all_steps = 0;
  double avg_steps = 0;
  int max_meters = 0;
  int all_meters = 0;
  double avg_meters = 0;
  double max_calories = 0;
  double all_calories = 0;
  double avg_calories = 0;


  String yearMonthDayDate = formattedDate;
  String yearMonthDate = formattedMonth;
  var currentDay = new DateTime.now();

  int get getStepsValue {
    if (sumSteps == null) {
      return 0;
    }
    return sumSteps;
  }

  String getDate() {
    return yearMonthDayDate;
  }

  void backDate() {
    currentDay = currentDay.subtract(Duration(days: 1));
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(currentDay);
    yearMonthDayDate = formatted;
    makeDataRequest();
    notifyListeners();
  }

  void forwardDate() {
    if (currentDay.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      print('is after');
    } else {
      currentDay = currentDay.add(Duration(days: 1));
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(currentDay);
      yearMonthDayDate = formatted;
      makeDataRequest();
      notifyListeners();
    }
  }

  void backMonth() {
    currentDay = currentDay.subtract(Duration(days: 30));
    var formatter = new DateFormat('yyyy-MM');
    String formatted = formatter.format(currentDay);
    yearMonthDate = formatted;
    //makeDataRequest();
    notifyListeners();
  }

  void forwardMonth() {
    if (currentDay.isAfter(DateTime.now().subtract(Duration(days: 30)))) {
      print('is after');
    } else {
      currentDay = currentDay.add(Duration(days: 30));
      var formatter = new DateFormat('yyyy-MM');
      String formatted = formatter.format(currentDay);
      yearMonthDate = formatted;
      //   makeDataRequest();
      notifyListeners();
    }
  }

  makeDataRequest() async {
    chartData = [];
    sumSteps = 0;
    print('init: $yearMonthDayDate');
    var response = await http.get(
        urlEmulator + '/day/stats' + '?id=${1}' + '&date=$yearMonthDayDate');
    print(response.statusCode);
    var stepsData = json.decode(response.body);
    print(stepsData);
    var chartSteps = stepsData['chart_data'];
    var stepsTime = stepsData['time'];
    for (var v in chartSteps) {
      v = json.decode(v);
      chartData.add(new TimeSeriesSteps().fromMap(v));
    }
    for (var c in chartData) {
      sumSteps += c.steps;
    }

    walkingTime = stepsTime['walking'];
    runningTime = stepsTime['running'];
    cyclingTime = stepsTime['cycling'];

    walking = new Duration(milliseconds: walkingTime);
    running = new Duration(milliseconds: runningTime);
    cycling = new Duration(milliseconds: cyclingTime);

    notifyListeners();
    statusPage++;
  }

  makeMetersRequest(int userId) async {
    chartMetersData = [];
    sumMeters = 0;
    var response = await http.get(
        urlEmulator + '/day/meters' + '?id=${userId}' + '&date=$yearMonthDayDate');
    print(response.statusCode);
    var metersData = json.decode(response.body);
    for (var v in metersData) {
      chartMetersData.add(new TimeSeriesSteps().fromMap(v));
    }
    for (var c in chartMetersData) {
      sumMeters += c.steps;
    }
    notifyListeners();
    statusPage2++;
  }

  makeCaloriesRequest() async {
    chartCaloriesData = [];
    sumCalories = 0;
    print('init: $yearMonthDayDate');
    var response = await http.get(
        urlEmulator + '/day/calories' + '?id=${1}' + '&date=$yearMonthDayDate');
    print(response.statusCode);
    var caloriesData = json.decode(response.body);
    print('Calories: $caloriesData');
    for (var v in caloriesData) {
      chartCaloriesData.add(new TimeSeriesCalories().fromMap(v));
    }
    for (var c in chartCaloriesData) {
      sumCalories += c.calories;
    }
    notifyListeners();
    statusPage3++;
  }




  getMonthStepsData() async {
    var response = await http.get(
        urlEmulator + '/month/stats' + '?id=${1}' + '&date=$yearMonthDate');
    print(response.statusCode);
    var s = json.decode(response.body);
    print('S $s');
    var monthSteps = s['chart_data'];
    for (var v in monthSteps) {
      v = json.decode(v);
      chartDataMonth.add(new TimeSeriesSteps().fromMap(v));
    }

    activity = s['activity_time'];
    activityTime = Duration(milliseconds: activity);
    max_steps = s['max_steps'];
    all_steps = s['all_steps'];
    avg_steps = s['avg_steps'];
    notifyListeners();
  }

  getMonthMetersData() async {
    print('Month meters data...');
    var response = await http.get(
        urlEmulator + '/month/meters' + '?id=${1}' + '&date=$yearMonthDate');
    print(response.statusCode);
    var s = json.decode(response.body);
    print('Month meters data: $s');
    var monthMeters = s['meters_data'];
    for (var v in monthMeters) {
      v = json.decode(v);
      chartMetersDataMonth.add(new TimeSeriesSteps().fromMap(v));
    }

    max_meters = s['max_meters'];
    all_meters = s['all_meters'];
    avg_meters = s['avg_meters'];
    notifyListeners();
  }

  getMonthCaloriesData() async {
    print('Calories meters data...');
    var response = await http.get(
        urlEmulator + '/month/calories' + '?id=${1}' + '&date=$yearMonthDate');
    print(response.statusCode);
    var s = json.decode(response.body);
    print('Month calories data: $s');
    var monthCalories = s['calories_data'];
    for (var v in monthCalories) {
      v = json.decode(v);
      chartCaloriesDataMonth.add(new TimeSeriesCalories().fromMap(v));
    }

    max_calories = s['max_calories'];
    all_calories = s['all_calories'];
    avg_calories = s['avg_calories'];
    notifyListeners();
  }

  List<charts.Series<TimeSeriesSteps, DateTime>> createDataChart(
      List<TimeSeriesSteps> data) {
    return [
      new charts.Series<TimeSeriesSteps, DateTime>(
        id: 'Steps',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSteps Steps, _) => Steps.time,
        measureFn: (TimeSeriesSteps Steps, _) => Steps.steps,
        measureLowerBoundFn: (TimeSeriesSteps Steps, _) => Steps.steps,
        measureUpperBoundFn: (TimeSeriesSteps Steps, _) => Steps.steps + 5,
        data: data,
      )
    ];
  }


  List<charts.Series<TimeSeriesSteps, DateTime>> createBarChart(
      List<TimeSeriesSteps> data) {
    return [
      new charts.Series<TimeSeriesSteps, DateTime>(
        id: 'Content',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSteps content, _) => content.time,
        measureFn: (TimeSeriesSteps content, _) => content.steps,
        data: data,
      )
    ];
  }

  List<charts.Series<TimeSeriesCalories, DateTime>> createBarChartCalories(
      List<TimeSeriesCalories> data) {
    return [
      new charts.Series<TimeSeriesCalories, DateTime>(
        id: 'Calories',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesCalories calories, _) => calories.time,
        measureFn: (TimeSeriesCalories calories, _) => calories.calories,
        data: data,
      )
    ];
  }
}
