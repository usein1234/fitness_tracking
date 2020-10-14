import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_trainee.dart';
import 'trainee_steps_page.dart';
import 'trainee_stat.dart';

import '../scoped_models/main_model.dart';

class TraineeGoalsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TraineeGoalsPageState();
  }
}

class _TraineeGoalsPageState extends State<TraineeGoalsPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    // TODO: implement build
    if (_selectedIndex == 2) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_comment),
              title: Text('Statistics'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.touch_app),
              title: Text('Goals'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('Chose'),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Personal info'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/trainee/info'),
              ),
              ListTile(
                leading: Icon(Icons.person_pin),
                title: Text('Coach info'),
                onTap: () =>
                    Navigator.pushReplacementNamed(
                        context, '/trainee/coach/info'),
              ),
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('View coaches'),
                onTap: () =>
                    Navigator.pushNamed(context, '/trainee/coach/chose'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Today goal'),
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return IconButton(
                      icon: Icon(Icons.refresh), onPressed: () => model.getGoal(1, model.yearMonthDayDate));
                }),
          ],
        ),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              if (model.goalPageStatus == 0) {
                model.getGoal(1, model.yearMonthDayDate);
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    GoalContainer(index, model.goalInfo),
                itemCount: 1,
              );
            }),
      );
    } else if (_selectedIndex == 0) {
      return HomeTraineePage();
    } else if (_selectedIndex == 1) {
      return TraineeStatPage();
    }
  }
}

class GoalContainer extends StatelessWidget {
  final int index;
  final Map<String, dynamic> goalData;

  GoalContainer(this.index, this.goalData);

//  Icon _buildIcon(index) {
//    if (goalsData['type'][index] == 'running') {
//      return Icon(
//        Icons.directions_run,
//      );
//    } else if (goalsData['type'][index] == 'cycling') {
//      return Icon(Icons.directions_bike);
//    } else {
//      return Icon(Icons.directions_walk);
//    }
//  }


  @override
  Widget build(BuildContext context) {
    double percentageTime = goalData['today_duration'] /
        goalData['goal_duration'];
    double percentageTimeLabel = percentageTime * 100;
    double percentageDistance = goalData['today_meters'] /
        goalData['goal_meters'];
    double percentageDistanceLabel = percentageDistance * 100;
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => print('Hello'),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.green,
                      Colors.black12,
                    ],
                  ),
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(3.0)),
              margin: EdgeInsets.only(left: 0.0),
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
              width: deviceWidth * 0.95,
              // height: 110.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${goalData['type']}',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Colors.black26),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.title),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'Title: ',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text('${goalData['title']}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding:
                          EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: Colors.black12),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.description),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                'Description: ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${goalData['description']}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => print('Hello'),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.green,
                      Colors.black12,
                    ],
                  ),
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(3.0)),
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              width: deviceWidth * 0.95,
              // height: 110.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(4.0)),
                        padding: EdgeInsets.all(2.0),
                        child: Text('Goal',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 70.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(4.0)),
                        padding: EdgeInsets.all(2.0),
                        child: Text('Trainee data',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Colors.black26),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.directions_walk),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'Distance: ',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text('${goalData['goal_meters']} m',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Text('${goalData['today_meters']} m',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding:
                          EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: Colors.black26),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.timer),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                'Duration: ',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Text(
                            '${Duration(milliseconds: goalData['goal_duration'])
                                .inMinutes} min',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text('${Duration(
                              milliseconds: goalData['today_duration'])
                              .inMinutes} min',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => print('Hello'),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.green,
                      Colors.black12,
                    ],
                  ),
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(3.0)),
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 19.0, bottom: 16.0),
              width: deviceWidth * 0.95,
              // height: 110.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Distance progress: ${percentageDistanceLabel
                          .toString()}%',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(),
                  LinearProgressIndicator(
                    value: percentageDistance,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.green,
                    Colors.black12,
                  ],
                ),
                color: Colors.black87,
                borderRadius: BorderRadius.circular(3.0)),
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 19.0, bottom: 16.0),
            width: deviceWidth * 0.95,
            // height: 110.0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Time progress ${percentageTimeLabel.toString()}%',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(),
                LinearProgressIndicator(
                  value: percentageTime,
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                ),
              ],
            ),
          )
//          Padding(
//            padding: EdgeInsets.all(6.0),
//            child: Container(
//              padding: EdgeInsets.all(25.0),
//              decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  color: Colors.green,
//                  border: Border.all(color: Colors.black12, width: 2.0)),
//              child: Column(
//                children: <Widget>[
//                  _buildIcon(index),
//                  Text(
//                    '${goalsData['type'][index]}',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  )
//                ],
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
