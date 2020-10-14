import '../entity/goal.dart';
import '../database/postgres.dart';
import 'package:fitness_tracking_2/mapper/interface_mapper.dart';

class GoalMapperImpl implements Mapper {
  var connection = ConnectionManager.getConnection();
  bool _isSuccess;

  get success {
    return _isSuccess;
  }

  Goal findById(int id) {
    return null;
  }

  Future<bool> insert(dynamic goal) async {
    await connection.open();
    await connection.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO goal (trainee_id, date, completed, duration_workout, coach_id, distance, distance_unit,title, description) values "
          "(@traineeIdValue, @dateValue, @completedValue, @timeValue, @coachIdValue, @distanceValue,"
          "@unitValue, @titleValue, @descriptionValue)",
          substitutionValues: {
            'traineeIdValue': goal.traineeId,
            'dateValue': goal.rangeFirstDate,
            'completedValue': false,
            'timeValue': goal.goalDuration,
            'coachIdValue': goal.coachId,
            'distanceValue': goal.distance,
            'unitValue': goal.distanceUnit,
            'titleValue': goal.title,
            'descriptionValue': goal.description,
          });
      _isSuccess = true;
      print('Success...');
    });
    return _isSuccess;
  }

  getGoals(int userId, String date) async {
    var resultData;
    int coachId;
    await connection.open();
    await connection.transaction((ctx) async {
      var result = await ctx.query(
          "select (select coach_id from trainee where trainee_id = @id),distance, title, description, duration_workout from goal where trainee_id = @id and date = @today;",
          substitutionValues: {
            'id': userId,
            'today': '2019-06-04',
          });
      resultData = result;
      coachId = result[0][0];

      if (result.length > 0) {
        var result2 = await ctx.query(
            "select work_area from coach where coach_id = @id ;",
            substitutionValues: {
              'id': coachId,
            });
        resultData[0].add(result2[0][0]);
      }

      print('Success...');
    });
    return resultData;
  }

  Future<bool> findExistingData(int userId, String date) async {
    await connection.open();
    var result = await connection.query(
        'select * from goal where trainee_id = @id and date = @date',
        substitutionValues: {'id': userId, 'date': '2019-06-27'});
    if (result.length > 0) {
      return true;
    }
    return false;
  }

  updateDate(dynamic goal, String date) async {
    await connection.query(
        'update goal set duration_workout= @duration, coach_id=@coach_id, distance=@distance, distance_unit = @unit,title = @title, description = @desc where trainee_id = @id and date=@date',
        substitutionValues: {
          'id': 1,
          'date': '2019-06-27',
          'duration': goal.goalDuration,
          'coach_id': goal.coachId,
          'distance': goal.distance,
          'unit': goal.distanceUnit,
          'title': goal.title,
          'desc': goal.description,
        });
  }

  update(dynamic goal){

  }
  delete(dynamic trainee) {}
}
