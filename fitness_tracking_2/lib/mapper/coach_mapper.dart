import 'package:dbcrypt/dbcrypt.dart';
import '../entity/coach.dart';
import '../database/postgres.dart';
import 'package:fitness_tracking_2/mapper/interface_mapper.dart';

class CoachMapperImpl implements Mapper {
  var connection = ConnectionManager.getConnection();
  bool _isSuccess;

  get success {
    return _isSuccess;
  }

   findById(int id) async {
    Coach coach = new Coach();
    await connection.open();
    var result = await connection.query('select full_name, email, experience, gender, age, work_area, review_score from coach '
        'where coach_id = @id ',substitutionValues: {
      'id': 1
    });
    coach.fullName = result[0][0];
    coach.email = result[0][1];
    coach.setExpValue = result[0][2];
    coach.gender = result[0][3];
    coach.age = result[0][4];
    coach.setAreaValue = result[0][5];
    coach.setScore = result[0][6];

    return coach;

  }

  Future<bool> insert(dynamic coach) async {
    var hashedPassword = new DBCrypt().hashpw(coach.getPassword, new DBCrypt().gensalt());
    await connection.open();
    await connection.transaction((ctx) async {
      var result = await ctx.query(
          "SELECT email FROM coach where email= @emailValue",
          substitutionValues: {'emailValue': coach.getEmail});
      if (result.length == 0) {
        await ctx.query(
            "INSERT INTO coach (full_name, email, password, age, gender, experience, work_area, number_trainee) values (@nameValue, @emailValue, @passwordValue, @ageValue, @genderValue, @expValue,"
                "@areaValue, @numberTrainee)",
            substitutionValues: {
              'nameValue': coach.getName,
              'emailValue': coach.getEmail,
              'passwordValue': hashedPassword,
              'ageValue': coach.getAge,
              'genderValue': coach.getGender,
              'expValue': coach.expValue,
              'areaValue': coach.getAreaValue,
              'numberTrainee': coach.numOfEmployee,
            });
        _isSuccess = true;
      } else {
        print('There is a person with the same email...');
        _isSuccess = false;
      }
    });
    return _isSuccess;
  }

  findList() async{
    Coach data = new Coach();
    List<String> coachList = [];
    print('Coach list request....');
    await connection.open();
    await connection.transaction((ctx) async {
      var result = await ctx.query(
          "SELECT coach_id,full_name, gender, work_area, experience, review_score from coach");
      print(result);
      
      for(var row in result) {
        data.id = row[0];
        data.fullName = row[1];
        data.gender = row[2];
        data.setAreaValue = row[3];
        data.setExpValue = row[4];
        data.setScore = row[5];
        coachList.add(data.toMap());
      }
      print(coachList);
    });
    return coachList;

  }

  findLoginData(String email, String password) async {
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "SELECT * FROM coach where email =  @email",
        substitutionValues: {'email': email});
    var isCorrect = new DBCrypt().checkpw(password, results[0][3]);
    if (results.length == 0 || !isCorrect) {
      print('No match for login details...');
    } else {
      Coach loginMatch = Coach.setValues(
          results[0][0],
          results[0][1],
          results[0][2],
          results[0][3],
          results[0][6],
          results[0][7],
          results[0][4],
          results[0][8],
          results[0][5]);
      return loginMatch;
    }
  }

  update(dynamic trainee) {}

  delete(dynamic trainee) {}
}
