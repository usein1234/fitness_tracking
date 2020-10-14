
abstract class User {
  int id;
  String fullName;
  String email;
  String password;
  int age;
  String gender;

  User() {
    id = null;
    fullName = '';
    email = '';
    password = '';
    age = 0;
    gender = '';
  }

  User.setValues(int id, String fullName, String email, String password, String gender, int age) {
    this.id = id;
    this.fullName = fullName;
    this.email = email;
    this.password = password;
    this.gender = gender;
    this.age = age;
  }

  set idValue(int id) {
    this.id = id;
  }

  set fullNameValue(String name) {
    this.fullName = name;
  }

  set emailValue(String email) {
    this.email = email;
  }

  set passwordValue(String password) {
    this.password = password;
  }

  set genderValue(String gender) {
    this.gender = gender;
  }

  set ageValue(int age) {
    this.age = age;
  }

  get getId {
    return id;
  }

  get getName {
    return fullName;
  }

  get getAge {
    return age;
  }

  get getEmail {
    return email;
  }

  get getPassword {
    return password;
  }

  get getGender {
    return gender;
  }

}

