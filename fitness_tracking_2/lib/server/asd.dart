import 'package:dbcrypt/dbcrypt.dart';

main() {
  var plainPassword1 = "123456789";
  var plainPassword = "123456789";
  var hashedPassword = new DBCrypt().hashpw(plainPassword, new DBCrypt().gensalt());
  var hashedPassword1 = new DBCrypt().hashpw(plainPassword1, new DBCrypt().gensalt());
  print(hashedPassword);

  var isCorrect = new DBCrypt().checkpw(hashedPassword1, hashedPassword);
  print(isCorrect);
  if(hashedPassword == hashedPassword1) {
    print('match');
  }
}
