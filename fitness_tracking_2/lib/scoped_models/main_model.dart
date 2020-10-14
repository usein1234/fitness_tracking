import 'package:scoped_model/scoped_model.dart';

import 'bluetooth_model.dart';
import 'statistics_activity_data.dart';
import 'user_model.dart';
import 'goal_model.dart';

class MainModel extends Model with UserModel, ActivityDataStatisticsModel, BluetoothModel, GoalModel {

}