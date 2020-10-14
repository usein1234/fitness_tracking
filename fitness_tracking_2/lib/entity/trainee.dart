import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'user.dart';

class Trainee extends User {
  int _weight;
  String _weightUnit;
  int _height;
  String _heightUnit;
  int _coachId;

  Trainee():super() {
    _weight = 0;
    _weightUnit = '';
    _height = 0;
    _weightUnit = '';
    _coachId = 0;
  }

  Trainee.setValues(int id, String name, String email, String password, String gender,
      int age, this._weight, this._weightUnit, this._height, this._heightUnit, this._coachId)
      : super.setValues(id, name, email, password, gender, age);

  Trainee.updateInfo(this._weight,this._weightUnit, this._height, this._heightUnit);

  set weightValue(int weight) {
    this._weight = weight;
  }

  set weightUnitValue(String weightUnit) {
    this._weightUnit = weightUnit;
  }

  set heightValue(int height) {
    this._height = height;
  }

  set heightUnitValue(String heightUnit) {
    this._heightUnit = heightUnit;
  }

  get getHeight {
    return _height;
  }

  get getHeightUnit {
    return _heightUnit;
  }

  get getWeight {
    return _weight;
  }

  get getWeightUnit {
    return _weightUnit;
  }

  get getCoachId {
    return _coachId;
  }

  Trainee copy(Trainee trainee) {
    this.id = trainee.id;
    this.fullName = trainee.fullName;
    this.email = trainee.email;
    this.age = trainee.age;
    this.gender = trainee.gender;
    this._weight = trainee._weight;
    this._weightUnit = trainee._weightUnit;
    this._height = trainee._height;
    this._heightUnit = trainee._heightUnit;
    this._coachId = trainee._coachId;
    return this;
  }

  void show() {
    print('id: $id');
    print('name: $fullName');
    print('email: $email');
    print('age: $age');
    print('gender: $gender');
    print('weight: $_weight');
    print('weightUnit: $_weightUnit');
    print('height: $_height');
    print('heightunit: $_heightUnit');
    print('coachid: $getCoachId');
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
    rawData['weight'] = this._weight;
    rawData['weightUnit'] = this._weightUnit;
    rawData['height'] = this._height;
    rawData['heightUnit'] = this._heightUnit;
    rawData['coachId'] = this._coachId;
    encodedData = json.encode(rawData);
    return encodedData;
  }

    Trainee fromMap(Map rawData) {
      Trainee user = new Trainee();
      user.idValue = rawData['id'];
      user.fullNameValue = rawData['fullName'];
      user.emailValue = rawData['email'];
      user.passwordValue = rawData['password'];
      user.genderValue = rawData['gender'];
      user.ageValue = rawData['age'];
      user._weight = rawData['weight'];
      user._weightUnit = rawData['weightUnit'];
      user._height = rawData['height'];
      user._heightUnit = rawData['heightUnit'];
      user._coachId = rawData['coachId'];
      return user;
    }
}
