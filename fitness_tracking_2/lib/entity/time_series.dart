import 'dart:convert';

  class TimeSeriesSteps {
    final DateTime time;
    final int steps;

    TimeSeriesSteps({this.time, this.steps});

    String toMap() {
      Map rawData = new Map();
      var encodedData;
      rawData['time'] = this.time.toString();
      rawData['steps'] = this.steps;
      encodedData = json.encode(rawData);
      return encodedData;
    }

    TimeSeriesSteps fromMap(Map rawData) {
      TimeSeriesSteps data =
          new TimeSeriesSteps(steps: rawData['steps'], time: DateTime.parse(rawData['time']));
      return data;
    }
  }

class TimeSeriesCalories {
  final DateTime time;
  final double calories ;

  TimeSeriesCalories({this.time, this.calories});

  String toMap() {
    Map rawData = new Map();
    var encodedData;
    rawData['time'] = this.time.toString();
    rawData['calories'] = this.calories;
    encodedData = json.encode(rawData);
    return encodedData;
  }

  TimeSeriesCalories fromMap(Map rawData) {
    TimeSeriesCalories data =
    new TimeSeriesCalories(calories: rawData['calories'], time: DateTime.parse(rawData['time']));
    return data;
  }
}
