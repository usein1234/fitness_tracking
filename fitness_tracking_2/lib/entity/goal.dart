import 'dart:convert' as packet;

class Goal {
  int traineeId;
  int coachId;
  String title;
  int distance;
  String distanceUnit;
  int goalDuration;
  String rangeFirstDate;
  String description;

  Goal(
      {this.traineeId,
      this.coachId,
      this.title,
      this.distance,
      this.distanceUnit,
      this.goalDuration,
      this.rangeFirstDate,
      this.description});

  String toMap() {
    Map rawData = new Map();
    var encodedData;
    rawData['trainee_id'] = this.traineeId;
    rawData['coach_id'] = this.coachId;
    rawData['title'] = this.title;
    rawData['distance'] = this.distance;
    rawData['distance_unit'] = this.distanceUnit;
    rawData['duration'] = this.goalDuration;
    rawData['first_date'] = this.rangeFirstDate;
    rawData['description'] = this.description;
    encodedData = packet.json.encode(rawData);
    return encodedData;
  }

  Goal fromMap(Map rawData) {
    Goal goal = new Goal();
    goal.traineeId = rawData['trainee_id'];
    goal.coachId = rawData['coach_id'];
    goal.title = rawData['title'];
    goal.distance = rawData['distance'];
    goal.distanceUnit = rawData['distance_unit'];
    goal.goalDuration = rawData['duration'];
    goal.rangeFirstDate = rawData['first_date'];
    goal.description = rawData['description'];
    return goal;
  }
}
