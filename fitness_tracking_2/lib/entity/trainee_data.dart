import 'dart:convert';
import 'package:intl/intl.dart';

class TraineeData {
  int userId = 0;
  int batteryLevel = 0;
  int steps = 0;
  int meters = 0;

  double calories = 0.0;
  DateTime time = DateTime.now();
  String trainingMode = 'walking';
  int walkingMinutes = 0;
  int runningMinutes = 0;
  int cyclingMinutes = 0;

  TraineeData(
      {this.userId,
      this.batteryLevel,
      this.steps,
      this.meters,
      this.calories,
      this.trainingMode,
      this.walkingMinutes,
      this.cyclingMinutes,
      this.runningMinutes,
      this.time});

  void show() {
    print('Battery level: ${this.batteryLevel} %');
    print('Steps: ${this.steps}');
    print('Meters: ${this.meters * 3}');
    print('Calories: ${this.calories / 10}');
    print('Trainig mode: ${this.trainingMode}');
  }

  updateData({int batteryLevel, int steps, int meters, int calories, int trainingMode}) {
    this.batteryLevel = batteryLevel;
    this.steps += steps;
    this.meters += meters * 3;
    this.calories += calories / 10;
    if (trainingMode == 64 || trainingMode < 64) {
      this.trainingMode = 'walking';
      this.walkingMinutes++;
    } else if (trainingMode == 128) {
      this.trainingMode = 'running';
      this.runningMinutes++;
    } else {
      this.trainingMode = 'cycling';
      this.cyclingMinutes++;
    }
    DateTime labelDate = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String formattedDate = formatter.format(labelDate);
    DateTime now = DateTime.parse(formattedDate);
    this.time = now;
  }

  String toMap() {
    Map rawData = new Map();
    var encodedData;
    rawData['user_id'] = this.userId;
    rawData['steps'] = this.steps;
    rawData['meters'] = this.meters;
    rawData['calories'] = this.calories;
    rawData['time'] = this.time.toString();
    rawData['activity'] = this.trainingMode;
    encodedData = json.encode(rawData);
    return encodedData;
  }

  TraineeData fromMap(Map rawData) {
    TraineeData user = new TraineeData();
    user.userId = rawData['user_id'];
    user.steps = rawData['steps'];
    user.meters = rawData['meters'];
    user.calories = rawData['calories'];
    user.time = DateTime.parse(rawData['time']);
    user.trainingMode = rawData['activity'];
    return user;
  }

  int get getSteps {
    return steps;
  }
}
