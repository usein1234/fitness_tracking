import '../entity/trainee.dart';
import '../database/postgres.dart';
import 'package:fitness_tracking_2/mapper/interface_mapper.dart';
import 'package:dbcrypt/dbcrypt.dart';

class TraineeMapperImpl implements Mapper {
  var connection = ConnectionManager.getConnection();
  bool _isSuccess;

  get success {
    return _isSuccess;
  }

  Trainee findById(int id) {
    return null;
  }

  Future<bool> insert(dynamic trainee) async {
    var hashedPassword = new DBCrypt().hashpw(trainee.getPassword, new DBCrypt().gensalt());
    await connection.open();

    await connection.transaction((ctx) async {
      var result = await ctx.query(
          "SELECT email FROM trainee where email= @emailValue",
          substitutionValues: {'emailValue': trainee.getEmail});
      if (result.length == 0) {
        await ctx.query(
            "INSERT INTO trainee (full_name, email, password, age, weight, weight_unit, height, "
                "height_unit, gender, coach_id) values (@nameValue, @emailValue, @passwordValue, @ageValue, "
                "@weightValue, @weightUnit,"
            "@heightValue, @heightUnit, @genderValue, @coachId)",
            substitutionValues: {
              'nameValue': trainee.getName,
              'emailValue': trainee.getEmail,
              'passwordValue': hashedPassword,
              'ageValue': trainee.getAge,
              'weightValue': trainee.getWeight,
              'weightUnit': trainee.getWeightUnit,
              'heightValue': trainee.getHeight,
              'heightUnit': trainee.getHeightUnit,
              'genderValue': trainee.getGender,
              'coachId': trainee.getCoachId,
            });
        _isSuccess = true;
      } else {
        print('There is a person with the same email...');
        _isSuccess = false;
      }
    });
    return _isSuccess;
  }

  findLoginData(String email, String password) async {
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "SELECT * FROM trainee where email =  @email",
        substitutionValues: {'email': email});

    var isCorrect = new DBCrypt().checkpw(password, results[0][3]);
    if (results.length == 0 || !isCorrect) {
      print('No match for login details...');
    } else {
      Trainee loginMatch = Trainee.setValues(
          results[0][0],
          results[0][1],
          results[0][2],
          results[0][3],
          results[0][8],
          results[0][4],
          results[0][5],
          results[0][6],
          results[0][7],
          results[0][8],
          results[0][10]);
      return loginMatch;
    }
  }

  Future<List<String>> getTraineeList(int id) async {
    List<String> resultData = [];
    await connection.open();
    var result = await connection.query(
        "SELECT * FROM trainee where coach_id= @coachId",
        substitutionValues: {'coachId': id});

    for (var row in result) {
      resultData.add(new Trainee.setValues(row[0], row[1], row[2], row[3],
              row[9], row[4], row[5], row[6], row[7], row[8], row[10])
          .toMap());
    }
    return resultData;
  }
  
  insertCoach(int trainee, int coach) async {
    await connection.open();
    var result = await connection.query('update trainee set coach_id = @coachValue where trainee_id = @traineeValue ',substitutionValues: {
      'coachValue': coach,
      'traineeValue': trainee,
    });

    print(result);
  }

  update(dynamic trainee) async {
    await connection.open();
    await connection.query(
        "update trainee set full_name = @nameValue, age = @ageValue, weight = @weightValue, weight_unit = @weightUnitValue, height = @heightValue, height_unit = @heightUnitValue "
            "where trainee_id = @traineeIdValue", substitutionValues: {
          'nameValue': trainee.fullName,
          'ageValue': trainee.age,
          'weightValue': trainee.getWeight,
          'weightUnitValue': trainee.getWeightUnit,
          'heightValue': trainee.getHeight,
          'heightUnitValue': trainee.getHeightUnit,
          'traineeIdValue': trainee.id,
    });
  }
  
  findTodayResult(int userId, String date) async {
    var resultData;
    await connection.open();
    var result = await connection.query('select duration, meters from trainee_data where trainee_id = @id and date = @today and '
        'activity_type = @type ',substitutionValues: {
      'id': 1,
      'today': '2019-06-04',
      'type': 'running'
    });


    print('todayyyyy');
    return result;
  }
  
  setCompleted(int userId, String date) async {
    await connection.query('update goal set completed = @completed where trainee_id = @id and date = @today', substitutionValues: {
      'id': userId,
      'today': '2019-06-03',
      'completed': true
    });
  }

  delete(dynamic trainee) async{
    await connection.open();
    var result = await connection.query('delete from trainee where trainee_id = @id', substitutionValues: {
      'id': trainee,
    });
  }
}
