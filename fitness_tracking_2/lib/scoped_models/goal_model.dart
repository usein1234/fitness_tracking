import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import '../entity/goal.dart';

var urlEmulator = 'http://10.0.2.2:3000';
var urlAndroidDevice = 'http://localhost:3000';

class GoalModel extends Model {
  List<Goal> userGoals = [];
  int goalPageStatus = 0;
  Map<String, dynamic> goalInfo = {
    'title': '',
    'description': '',
    'type': 'Info',
    'completed': false,
    'goal_meters': 1,
    'today_meters': 1,
    'goal_duration': 1,
    'today_duration': 1,
  };

  Future<bool> createGoal(Goal data, String date) async {
    var requestResponse =
        await http.post(urlEmulator + '/trainee/goal/set' + '?date=${date}', body: data.toMap());
    print('requestResponse code: ${requestResponse.statusCode}');
    print('requestResponse: $requestResponse');
    if (requestResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  getGoal(int userId, String date) async {
    print('getting goals');
    var requestResponse =
    await http.get(urlEmulator + '/trainee/goal/list' + '?id=${userId}' + '&date=${date}');
    print('requestResponse code: ${requestResponse.statusCode}');
    print('requestResponse: $requestResponse');
    var result = json.decode(requestResponse.body);
    print(result);
    goalInfo = result;
    notifyListeners();
    goalPageStatus++;
  }

}
