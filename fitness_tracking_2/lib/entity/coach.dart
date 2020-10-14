import 'dart:convert';

import 'user.dart';

class Coach extends User {
  int _experience;
  String _area;
  int _numberOfTrainee;
  double _score;

  Coach(): super() {
    _experience = null;
    _area = '';
    _numberOfTrainee = null;
    _score = null;
  }


  Coach.setValues(int id, String name, String email, String password, String gender,
      int age, this._experience, this._area, this._numberOfTrainee)
      : super.setValues(id, name, email, password, gender, age);


  int get expValue {
    return _experience;
  }

  String get areaValue {
    return _area;
  }

  int get numOfEmployee {
    return _numberOfTrainee;
  }

  double get getScore {
    return _score;
  }

  set setExpValue (int value) {
    _experience = value;
  }

  set setAreaValue (String value) {
    _area = value;
  }

  set setNumTrainee (int value) {
    _numberOfTrainee = value;
  }

  set setScore (double score) {
    _score = score;
  }
  String toMap() {
    Map rawData = new Map();
    var encodedData;
    rawData['id'] = this.getId;
    rawData['fullName'] = this.getName;
    rawData['email'] = this.email;
    rawData['password'] = this.getPassword;
    rawData['age'] = this.getAge;
    rawData['gender'] = this.getGender;
    rawData['experience'] = this.expValue;
    rawData['work_area'] = this.areaValue;
    rawData['number_employee'] = this.numOfEmployee;
    rawData['score'] = this._score;
    encodedData = json.encode(rawData);
    return encodedData;
  }

  Coach fromMap(Map rawData) {
    Coach user = new Coach();
    user.idValue = rawData['id'];
    user.fullNameValue = rawData['fullName'];
    user.emailValue = rawData['email'];
    user.passwordValue = rawData['password'];
    user.genderValue = rawData['gender'];
    user.ageValue = rawData['age'];
    user.setExpValue = rawData['experience'];
    user.setAreaValue = rawData['work_area'];
    user.setNumTrainee = rawData['number_employee'];
    user._score = rawData['score'];
    return user;
  }

}
