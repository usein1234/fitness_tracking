import 'dart:async';
import 'dart:convert';
import 'package:postgres/postgres.dart';

class ConnectionManager {
  static String _url = 'localhost';
  static int _port = 5432;
  static String _database = 'trainfit';
  static String _userName = 'usein_fitness';
  static String _password = 'usein1234';
  static PostgreSQLConnection connection;

  static PostgreSQLConnection getConnection() {
    try {
      connection = new PostgreSQLConnection(_url, _port, _database,
          username: _userName, password: _password);
      return connection;
    } catch (exception) {
      print("Connection failed!");
    }
    return connection;
  }

  void connect() async {
    await connection.open();
  }
}
