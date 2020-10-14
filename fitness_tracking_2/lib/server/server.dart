import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http_server/http_server.dart';


import '../entity/trainee.dart';
import '../entity/coach.dart';
import '../entity/trainee_data.dart';
import '../entity/time_series.dart';
import '../entity/goal.dart';
import 'package:fitness_tracking_2/mapper/trainee_mapper.dart';
import 'package:fitness_tracking_2/mapper/trainee_data_mapper.dart';
import 'package:fitness_tracking_2/mapper/coach_mapper.dart';
import 'package:fitness_tracking_2/mapper/goal_data_mapper.dart';

import 'package:fitness_tracking_2/mapper/interface_mapper.dart';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    3000,
  );
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    if (request.method == 'POST') {
      print('POST request...');
      var data = await HttpBodyHandler.processRequest(request);
      var decodedData = json.decode(data.body);
      if (request.uri.path == '/login') {
        print('Login request...');
        handleAuthentication(decodedData, request);
      } else if (request.uri.path == '/signup/trainee') {
        print('/signup/trainee');
        handleTraineeRegistration(decodedData, request);
      } else if (request.uri.path == '/trainee/activity') {
        print('/trainee/activity');
        handleActivityData(decodedData, request);
      } else if (request.uri.path == '/signup/coach') {
        print('/signup/coach');
        handleCoachRegistration(decodedData, request);
      } else if (request.uri.path == '/trainee/goal/set') {
        var date = request.uri.queryParameters['date'];
        handleGoalCreation(decodedData, request, date);
      } else if (request.uri.path == '/trainee/update') {
        handleTraineeUpdate(decodedData, request);
      } else if (request.uri.path == '/coach/select') {
        var coachId = decodedData['coach_id'];
        var traineeId = decodedData['trainee_id'];
        print('server coach id: $coachId');
        print('server trainee id: $traineeId');
        selectCoach(request, traineeId, coachId);
      }
    } else if (request.method == 'GET') {
      print('GET request...');
      if (request.uri.path == '/day/stats') {
        var id = int.parse(request.uri.queryParameters['id']);
        var date = request.uri.queryParameters['date'];
        handleDayStat(request, id, date);
      } else if (request.uri.path == '/trainees') {
        handleTraineeList(request, 1);
      } else if (request.uri.path == '/month/stats') {
        handleMonthStats(request, 1, '2019-06');
      } else if (request.uri.path == '/coach/list') {
        handleCoachList(request);
      } else if (request.uri.path == '/day/meters') {
        var id = int.parse(request.uri.queryParameters['id']);
        var date = request.uri.queryParameters['date'];
        handleDayMeters(request, id, date);
      } else if (request.uri.path == '/month/meters') {
        var id = int.parse(request.uri.queryParameters['id']);
        var date = request.uri.queryParameters['date'];
        handleMonthMetersStats(request, id, date);
      } else if (request.uri.path == '/day/calories') {
        var id = int.parse(request.uri.queryParameters['id']);
        var date = request.uri.queryParameters['date'];
        handleDayCalories(request, id, date);
      } else if (request.uri.path == '/month/calories') {
        var id = int.parse(request.uri.queryParameters['id']);
        var date = request.uri.queryParameters['date'];
        handleMonthCaloriesStats(request, id, date);
      } else if (request.uri.path == '/trainee/goal/list') {
        var id = int.parse(request.uri.queryParameters['id']);
        var date = request.uri.queryParameters['date'];
        handleTraineeGoals(request, id, date);
      } else if (request.uri.path == '/coach/info') {
        var id = int.parse(request.uri.queryParameters['id']);
        getCoach(request, id);
      }
    } else if (request.method == 'DELETE') {
      if (request.uri.path == '/trainee/delete') {
        var id = int.parse(request.uri.queryParameters['id']);
        deleteTrainee(request, id);
      }
    }
  }
}

Future handleAuthentication(Map data, HttpRequest request) async {
  Map<String, dynamic> responseData = {
    'key': null,
    'user': null,
  };
  var email = data['email'];
  var password = data['password'];
  var accountType = data['accountType'];
  if (accountType == 'trainee') {
    TraineeMapperImpl mapper = new TraineeMapperImpl();
    Trainee loginMatch = await mapper.findLoginData(email, password);
    print(loginMatch);
    if (loginMatch == null) {
      request.response
        ..write('Login unsuccessfull')
        ..close();
    } else {
      responseData['key'] = 'trainee';
      responseData['user'] = loginMatch.toMap();
      request.response
        ..write(json.encode(responseData))
        ..close();
    }
  } else if (accountType == 'coach') {
    print('Coach login request...');
    CoachMapperImpl mapper = new CoachMapperImpl();
    Coach loginMatch = await mapper.findLoginData(email, password);
    print(loginMatch);
    if (loginMatch == null) {
      request.response
        ..write('Login unsuccessfull')
        ..close();
    } else {
      responseData['key'] = 'coach';
      responseData['user'] = loginMatch.toMap();
      request.response
        ..write(json.encode(responseData))
        ..close();
    }
  }
}

Future handleTraineeRegistration(dynamic content, HttpRequest request) async {
  Trainee userData = new Trainee().fromMap(content);
  Mapper mapper = new TraineeMapperImpl();
  print(userData.getEmail);
  var result = await mapper.insert(userData);
  print(result);
  if (result) {
    request.response
      ..write('Success registraiton!')
      ..close();
  } else {
    request.response
      ..write('unsuccessful')
      ..close();
  }
}

Future handleActivityData(dynamic content, HttpRequest request) async {
  TraineeData data = new TraineeData().fromMap(content);
  TraineeDataMapperImpl mapper = new TraineeDataMapperImpl();
  mapper.insert(data);
  print('Activity data...');
  request.response
    ..write('oby')
    ..close();
}

Future handleCoachRegistration(dynamic content, HttpRequest request) async {
  Coach userData = new Coach().fromMap(content);
  Mapper mapper = new CoachMapperImpl();
  print(userData.getEmail);
  var result = await mapper.insert(userData);
  print(result);
  if (result) {
    request.response
      ..write('Success registraiton!')
      ..close();
  } else {
    request.response
      ..write('unsuccessful')
      ..close();
  }
}

Future handleDayStat(HttpRequest request, id, String date) async {
  List<String> chartData = [];
  Map<String, int> stepsTimes = {
    'walking': null,
    'running': null,
    'cycling': null,
  };

  Map<String, dynamic> dayData = {'chart_data': chartData, 'time': stepsTimes};

  print('steps request');
  TraineeDataMapperImpl mapper = new TraineeDataMapperImpl();
  var s = await mapper.findDayDataById(date, id);
  chartData.add(new TimeSeriesSteps(
          time: new DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          steps: 0)
      .toMap());
  for (int i = 0; i < s['steps'].length; i++) {
    chartData.add(
        new TimeSeriesSteps(time: s['date'][i], steps: s['steps'][i]).toMap());
  }
  chartData.add(new TimeSeriesSteps(
          time: new DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
          steps: 0)
      .toMap());

  stepsTimes['walking'] = s['walk_time'][0];
  stepsTimes['running'] = s['run_time'][0];
  stepsTimes['cycling'] = s['cycle_time'][0];
  print('Chart data: $chartData ');
  var responseData = json.encode(dayData);
  request.response
    ..write(responseData)
    ..close();
}

Future handleTraineeList(HttpRequest request, int id) async {
  List<String> traineeList = [];
  print('getting trainee list...');
  TraineeMapperImpl mapper = new TraineeMapperImpl();
  traineeList = await mapper.getTraineeList(id);
  request.response
    ..write(traineeList)
    ..close();
}

Future handleGoalCreation(
    dynamic content, HttpRequest request, String date) async {
  Goal newGoal = new Goal().fromMap(content);
  GoalMapperImpl mapper = new GoalMapperImpl();
  var match = await mapper.findExistingData(newGoal.traineeId, date);
  if (match) {
    print('updating...');
    mapper.update(newGoal);
  } else {
    mapper.insert(newGoal);
  }
  request.response
    ..write('success')
    ..close();
}

Future handleTraineeUpdate(dynamic content, HttpRequest request) async {
  Trainee newTrainee = new Trainee().fromMap(content);
  Mapper mapper = new TraineeMapperImpl();
  mapper.update(newTrainee);
}

Future handleMonthStats(HttpRequest request, int id, String date) async {
  List<String> chartData = [];
  int activityTime = 0;
  int maxSteps = 0;
  int allSteps = 0;
  double avgSteps = 0.0;
  Map<String, dynamic> dataMonth = {
    'chart_data': chartData,
    'all_steps': 0,
    'avg_steps': 0,
    'activity_time': 0.0,
    'max_steps': 0,
  };
  print('handleMonthStats...');
  TraineeDataMapperImpl data = new TraineeDataMapperImpl();
  var result = await data.findMonthStepsData(id, date);
  for (var row in result) {
    activityTime += row[2];
    allSteps += row[0];
    if (row[0] > maxSteps) {
      maxSteps = row[0];
    }
  }
  chartData.add(new TimeSeriesSteps(
          time: new DateTime(DateTime.now().year, DateTime.now().month, 1),
          steps: 0)
      .toMap());
  for (var row in result) {
    chartData.add(new TimeSeriesSteps(time: row[1], steps: row[0]).toMap());
  }

  chartData.add(new TimeSeriesSteps(
          time: new DateTime(DateTime.now().year, DateTime.now().month, 30),
          steps: 0)
      .toMap());

  avgSteps = allSteps / 30;

  dataMonth['avg_steps'] = avgSteps;
  dataMonth['max_steps'] = maxSteps;
  dataMonth['activity_time'] = activityTime;
  dataMonth['all_steps'] = allSteps;
  dataMonth['chart_data'].sort();
  print('charData: $dataMonth');
  request.response
    ..write(json.encode(dataMonth))
    ..close();
}

handleMonthMetersStats(HttpRequest request, int id, String date) async {
  List<String> monthMeters = [];
  int maxMeters = 0;
  int allMeters = 0;
  double avgMeters = 0.0;
  Map<String, dynamic> dataMonth = {
    'meters_data': monthMeters,
    'all_meters': 0,
    'avg_meters': 0,
    'max_meters': 0,
  };
  print('handleMonthMetersStats...');
  TraineeDataMapperImpl data = new TraineeDataMapperImpl();
  var result = await data.findMetersMonthData(id, date);
  print('RsMonth: $result');
  for (var row in result) {
    allMeters += row[0];
    if (row[0] > maxMeters) {
      maxMeters = row[0];
    }
  }
  avgMeters = allMeters / 30;

  dataMonth['all_meters'] = allMeters;
  dataMonth['avg_meters'] = avgMeters;
  dataMonth['max_meters'] = maxMeters;

  monthMeters.add(new TimeSeriesSteps(
          time: new DateTime(DateTime.now().year, DateTime.now().month, 1),
          steps: 0)
      .toMap());
  for (var row in result) {
    monthMeters.add(new TimeSeriesSteps(time: row[1], steps: row[0]).toMap());
  }

  monthMeters.add(new TimeSeriesSteps(
          time: new DateTime(DateTime.now().year, DateTime.now().month, 30),
          steps: 0)
      .toMap());
  monthMeters.sort();

  request.response
    ..write(json.encode(dataMonth))
    ..close();
}

handleMonthCaloriesStats(HttpRequest request, int id, String date) async {
  List<String> monthCalories = [];
  double maxCalories = 0.0;
  double allCalories = 0.0;
  double avgCalories = 0.0;
  Map<String, dynamic> dataMonth = {
    'calories_data': monthCalories,
    'all_calories': 0,
    'avg_calories': 0,
    'max_calories': 0,
  };
  print('handleMonthCaloriesStats...');
  TraineeDataMapperImpl data = new TraineeDataMapperImpl();
  var result = await data.findCaloriesMonthData(id, date);
  print('CaloriesMonth: $result');
  for (var row in result) {
    allCalories += row[0];
    if (row[0] > maxCalories) {
      maxCalories = row[0];
    }
  }

  avgCalories = allCalories / 30;

  dataMonth['all_calories'] = allCalories;
  dataMonth['avg_calories'] = avgCalories;
  dataMonth['max_calories'] = maxCalories;

  monthCalories.add(new TimeSeriesCalories(
          time: new DateTime(DateTime.now().year, DateTime.now().month, 1),
          calories: 0)
      .toMap());
  for (var row in result) {
    monthCalories
        .add(new TimeSeriesCalories(time: row[1], calories: row[0]).toMap());
  }

  monthCalories.add(new TimeSeriesCalories(
          time: new DateTime(DateTime.now().year, DateTime.now().month, 30),
          calories: 0)
      .toMap());
  monthCalories.sort();

  request.response
    ..write(json.encode(dataMonth))
    ..close();
}

Future handleDayMeters(HttpRequest request, int id, String date) async {
  List<String> dayMetersData = [];
  TraineeDataMapperImpl mapper = new TraineeDataMapperImpl();
  var meters = await mapper.findDayMeters(id, date);

  dayMetersData.add(new TimeSeriesSteps(
          time: new DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          steps: 0)
      .toMap());
  for (var row in meters) {
    dayMetersData.add(new TimeSeriesSteps(time: row[1], steps: row[0]).toMap());
  }

  dayMetersData.add(new TimeSeriesSteps(
          time: new DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
          steps: 0)
      .toMap());
  dayMetersData.sort();

  print('DayMetersData: $dayMetersData');

  request.response
    ..write(dayMetersData)
    ..close();
}

Future handleDayCalories(HttpRequest request, int id, String date) async {
  List<String> dayCaloriesData = [];
  TraineeDataMapperImpl mapper = new TraineeDataMapperImpl();
  var calories = await mapper.findDayCalories(id, date);

  dayCaloriesData.add(new TimeSeriesCalories(
          time: new DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          calories: 0)
      .toMap());
  for (var row in calories) {
    dayCaloriesData
        .add(new TimeSeriesCalories(time: row[1], calories: row[0]).toMap());
  }

  dayCaloriesData.add(new TimeSeriesCalories(
          time: new DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
          calories: 0)
      .toMap());
  dayCaloriesData.sort();

  print('DayCaloriesData: $dayCaloriesData');

  request.response
    ..write(dayCaloriesData)
    ..close();
}

Future handleCoachList(HttpRequest request) async {
  CoachMapperImpl coach = new CoachMapperImpl();
  var s = await coach.findList();
  request.response
    ..write(s)
    ..close();
}

Future selectCoach(HttpRequest request, int trainee, int coach) async {
  print('heyyyy');
  TraineeMapperImpl trainee1 = new TraineeMapperImpl();
  trainee1.insertCoach(trainee, coach);
  request.response
    ..write('success')
    ..close();
}

Future handleTraineeGoals(HttpRequest request, int userId, String date) async {
  Map resultData = {
    'title': null,
    'description': null,
    'type': null,
    'completed': false,
    'goal_meters': null,
    'today_meters': null,
    'goal_duration': null,
    'today_duration': null,
  };
  int duration = 0;
  int meters = 0;
  print('handleGoalList...');
  GoalMapperImpl goals = new GoalMapperImpl();
  TraineeMapperImpl traineeData = new TraineeMapperImpl();
  var todayGoal = await goals.getGoals(userId, date);
  var todayResults = await traineeData.findTodayResult(userId, date);
  for (var c in todayResults) {
    duration += c[0];
    meters += c[1];
  }

  if (meters >= todayGoal[0][1] && duration <= todayGoal[0][4]) {
    print('Goal completed');
    traineeData.setCompleted(userId, date);
  } else {
    print('Goal not completed');
  }

  resultData['goal_meters'] = todayGoal[0][1];
  resultData['today_meters'] = meters;
  resultData['goal_duration'] = todayGoal[0][4];
  resultData['today_duration'] = duration;
  resultData['title'] = todayGoal[0][2];
  resultData['description'] = todayGoal[0][3];
  resultData['type'] = todayGoal[0][5];

  print(duration);
  print(meters);

  print(todayGoal);
  request.response
    ..write(json.encode(resultData))
    ..close();
}

Future deleteTrainee(HttpRequest request, int id) async {
  Mapper user = new TraineeMapperImpl();
  var state = await user.delete(id);
  request.response
    ..write('sss')
    ..close();
}

Future getCoach(HttpRequest request, int id) async {
  CoachMapperImpl coach = new CoachMapperImpl();
  Coach user = await coach.findById(id);
  request.response
    ..write(user.toMap())
    ..close();
}
