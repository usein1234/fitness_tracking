import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';


import '../entity/trainee.dart';
import '../entity/coach.dart';

var urlEmulator = 'http://10.0.2.2:3000';
var urlAndroidDevice = 'http://localhost:3000';

class UserModel extends Model{
  //current user
  Trainee authenticatedTrainee = new Trainee();
  Coach authenticatedCoach = new Coach();
  Coach traineeCoach = new Coach();
  List<Trainee> traineeList = [];
  List<Coach> coachList = [];
  String distanceValue = 'meter';
  int requestStatus = 0;



  Future<bool> authenticateUser(Map user) async {
    print('Authentication...');
    var response = await http.post(urlEmulator + '/login', body: json.encode(user));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200 && response.body.toString() != 'Login unsuccessfull') {
      var test = json.decode(response.body);
      if(test['key'] == 'coach') {
        print("Coach authenticated!");
        Coach user = new Coach().fromMap(json.decode(test['user']));
        authenticatedCoach  = user;
        //authenticatedCoach.idValue = user.id;
        return true;
      } else if(test['key'] == 'trainee') {
        print("Trainee authenticated!");
        Trainee user = new Trainee().fromMap(json.decode(test['user']));
        authenticatedTrainee.copy(user);
        authenticatedTrainee.show();
        getCoachInfo(1);
     //   authenticatedTrainee.idValue = user.id;
        return true;
      }
    }
    return false;
  }

  Future registerTrainee(Trainee user) async {
    var requestResponse = await http.post(urlEmulator + '/signup/trainee', body: user.toMap());
    print('Response status: ${requestResponse.statusCode}');
    print('Response body: ${requestResponse.body}');
  }


  Future registerCoach(Coach user) async {
    var requestResponse = await http.post(urlEmulator + '/signup/coach', body: user.toMap());
    print('Response status: ${requestResponse.statusCode}');
    print('Response body: ${requestResponse.body}');
  }

  Future updateTrainee(Trainee user) async {
    var requestResponse = await http.post(urlEmulator + '/trainee/update', body: user.toMap());
    print('Response status: ${requestResponse.statusCode}');
    print('Response body: ${requestResponse.body}');
  }


  Future getCoachTrainees() async {
    print('getting coach list trainees data....');
    var requestResponse = await http.get(urlEmulator + '/trainees');
    print('Response status: ${requestResponse.statusCode}');
    if(requestResponse.statusCode == 200) {
      List data = json.decode(requestResponse.body);
      for(var c in data) {
        print(c);
        traineeList.add(new Trainee().fromMap(c));
      }
    }

    notifyListeners();

  }

  Future getCoachList() async {
    requestStatus++;
    print('getting coach list');
    var requestResponse = await http.get(urlEmulator + '/coach/list');
    print('Response status: ${requestResponse.statusCode}');
    if(requestResponse.statusCode == 200) {
      List data = json.decode(requestResponse.body);
      for(var c in data) {
        coachList.add(new Coach().fromMap(c));
      }
    }
    notifyListeners();
  }


  Future getCoachInfo(int coachId) async {
    var requestResponse = await http.get(urlEmulator + '/coach/info'+ '?id=${1}');
    print(requestResponse.statusCode);
    var response = json.decode(requestResponse.body);
    traineeCoach = new Coach().fromMap(response);
    print(response);
    notifyListeners();
  }

  Future selectCoach(int id) async {
    Map data = {
      'coach_id': id,
      'trainee_id': 1,
    };
    print('selecting.. coach');
    print('id: $id');
    var requestResponse = await http.post(urlEmulator + '/coach/select', body: json.encode(data));
    print('Response status: ${requestResponse.statusCode}');

  }

  Future deleteTrainee(int id) async {
    var requestResponse = await http.delete(urlEmulator + '/trainee/delete' + '?id=${15}');
    var result = json.decode(requestResponse.body);
    print(result);
  }



  void handleValue(String value) {
    if(value == 'km') {
      distanceValue = 'km';
      notifyListeners();
    } else if(value == 'meter' ) {
      distanceValue = 'meter';
      notifyListeners();
    }
  }


  List<Trainee> get getTraineeList {
    return traineeList;
}

  Coach get getCoach {
    return authenticatedCoach;
  }

  Trainee get getTrainee {
    return authenticatedTrainee;
  }

}