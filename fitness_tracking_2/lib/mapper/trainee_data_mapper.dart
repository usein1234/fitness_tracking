import '../entity/trainee.dart';
import '../database/postgres.dart';
import 'package:fitness_tracking_2/mapper/interface_mapper.dart';

import 'dart:typed_data';
import 'dart:convert';

class TraineeDataMapperImpl implements Mapper {
  var connection = ConnectionManager.getConnection();
  bool _isSuccess;

  get success {
    return _isSuccess;
  }

  Trainee findById(int id) {
    return null;
  }

  Future<bool> insert(dynamic trainee) async {
    await connection.open();

    await connection.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO trainee_data (trainee_id, steps, meters, kcal, time, activity_type, duration)"
          "values (@id, @steps, @meters, @kcal, @time, @activity,"
          " @duration)",
          substitutionValues: {
            'id': trainee.userId,
            'steps': trainee.steps,
            'meters': trainee.meters,
            'kcal': trainee.calories,
            'time': trainee.time,
            'activity': trainee.trainingMode,
            'duration': 6000,
          });
      _isSuccess = true;
    });
    return _isSuccess;
  }

  Future<Map> findDayDataById(String date, int id) async {
    Map<String, List<dynamic>> data = {
      'steps': [],
      'date': [],
      'walk_time': [],
      'run_time': [],
      'cycle_time': [],
    };
    await connection.open();

    await connection.transaction((ctx) async {
      print(date);
      var result = await ctx.query(
          "select time, steps from trainee_data where trainee_id = @id and date = @date",
          substitutionValues: {'id': 1, 'date': date});

      var result2 = await ctx.query(
          "select duration, activity_type from trainee_data where trainee_id = @id and date = @date",
          substitutionValues: {'id': 1, 'date': date});

      for (var row in result) {
        data['steps'].add(row[1]);
        data['date'].add(row[0]);
      }
      data['date'].sort();

      print('result9610: $result');

      int runTime = 0;
      int walkTime = 0;
      int cycleTime = 0;
      for (var row in result2) {
        if (row[1] == 'running') {
          runTime += row[0];
        } else if (row[1] == 'walking') {
          walkTime += row[0];
        } else if (row[1] == 'cycling') {
          cycleTime += row[0];
        }
      }

      print('Data: $data');
      print('Result2: $result2');
      var durationWalking = new Duration(milliseconds: runTime);
      var durationRunning = new Duration(milliseconds: walkTime);
      var durationCycling = new Duration(milliseconds: cycleTime);
      var walkHours = durationWalking.inHours;
      var walkMinutes = durationWalking.inMinutes;
      var runningHours = durationRunning.inHours;
      var runningMinutes = durationRunning.inMinutes;
      var cyclingHours = durationCycling.inHours;
      var cyclingMinutes = durationCycling.inMinutes;
      print('Walking hours $walkHours : minutes: $walkMinutes');
      print('Running hours $runningHours : minutes: $runningMinutes');
      print('Cycling hours $cyclingHours : minutes: $cyclingMinutes');
      data['walk_time'].add(walkTime);
      data['run_time'].add(runTime);
      data['cycle_time'].add(cycleTime);
    });

    return data;
  }

  findMonthStepsData(int id, String date) async {
    var resultData;
    await connection.open();
    print('MonthDataSteps....');
    await connection.transaction((ctx) async {
      print(date);
      var result = await ctx.query(
          "SELECT steps, date, duration FROM trainee_data where trainee_id = @id and date_part('year', date) = @year and date_part('month', date) = @month",
          substitutionValues: {'id': 1, 'year': '2019', 'month': '06'});
      resultData = result;
      print(result);
    });

    return resultData;
  }

  findMetersMonthData(int id, String date) async {
    var resultData;
    await connection.open();
    print('MonthDataMeters....');
    await connection.transaction((ctx) async {
      print(date);
      var result = await ctx.query(
          "SELECT meters, date FROM trainee_data where trainee_id = @id and date_part('year', date) = @year and date_part('month', date) = @month",
          substitutionValues: {'id': 1, 'year': '2019', 'month': '06'});
      resultData = result;
      print(result);
    });

    return resultData;
  }

  findCaloriesMonthData(int id, String date) async {
    var resultData;
    await connection.open();
    print('MonthDataCalories....');
    await connection.transaction((ctx) async {
      print(date);
      var result = await ctx.query(
          "SELECT kcal, date FROM trainee_data where trainee_id = @id and date_part('year', date) = @year and date_part('month', date) = @month",
          substitutionValues: {'id': 1, 'year': '2019', 'month': '06'});
      resultData = result;
      print(result);
    });

    return resultData;
  }

  findDayMeters(int id, String date) async {
    await connection.open();
    var result = await connection.query(
        'select meters, time from trainee_data where trainee_id = @id and date = @today',
        substitutionValues: {'id': id, 'today': date});

    return result;
  }

  findDayCalories(int id, String date) async {
    await connection.open();
    var result = await connection.query(
        'select kcal, time from trainee_data where trainee_id = @id and date = @today',
        substitutionValues: {'id': id, 'today': date});

    return result;
  }

  update(dynamic trainee) {}

  delete(dynamic trainee) {}
}
