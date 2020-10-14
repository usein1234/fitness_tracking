import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../entity/trainee.dart';
import '../entity/trainee_data.dart';
import '../scoped_models/main_model.dart';
import '../pages/trainee_stat.dart';
import '../pages/trainee_goals_page.dart';

class HomeTraineePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTraineePageState();
  }
}

class _HomeTraineePageState extends State<HomeTraineePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Container _buildCyclingField(TraineeData data) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.directions_bike),
          ),
          Text('cycling',
              style: TextStyle(fontSize: 17.0, fontFamily: 'DroidSans')),
          SizedBox(
            width: 110.0,
          ),
          Text('${data.cyclingMinutes.toString()} min',
              style: TextStyle(fontSize: 17.0, fontFamily: 'DroidSans'))
        ],
      ),
    );
  }

  Container _buildRunningField(TraineeData data) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.directions_run),
          ),
          Text('running',
              style: TextStyle(fontSize: 17.0, fontFamily: 'DroidSans')),
          SizedBox(
            width: 100.0,
          ),
          Text('${data.runningMinutes.toString()} min',
              style: TextStyle(fontSize: 17.0, fontFamily: 'DroidSans'))
        ],
      ),
    );
  }

  Container _buildWalkingField(TraineeData data) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.directions_walk),
          ),
          Text('walking',
              style: TextStyle(fontSize: 17.0, fontFamily: 'DroidSans')),
          SizedBox(
            width: 100.0,
          ),
          Text('${data.walkingMinutes.toString()} min',
              style: TextStyle(fontSize: 17.0, fontFamily: 'DroidSans'))
        ],
      ),
    );
  }

  Container _buildCaloriesCounterField(TraineeData data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.green[300],
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/calories.png',
                  width: 24.0,
                  height: 24.0,
                ),
                Container(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    'Kcal',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            '${data.calories.toString()}',
            style: TextStyle(fontSize: 17.0),
          )
        ],
      ),
    );
  }

  Container _buildMetersCounterField(TraineeData data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.green[300],
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/meter.png',
                  width: 24.0,
                  height: 24.0,
                ),
                Container(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    'Meters',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            '${data.meters.toString()}',
            style: TextStyle(fontSize: 17.0),
          ),
        ],
      ),
    );
  }

  Container _buildStepsCounterField(TraineeData data) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      padding: EdgeInsets.only(right: 3.0, top: 3.0, left: 3.0, bottom: 3.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/steps.png',
                  height: 24.0,
                  width: 24.0,
                ),
                Container(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    'Steps',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            '${data.steps.toString()}',
            //    '1318',
            style: TextStyle(fontSize: 17.0),
          )
        ],
      ),
    );
  }

  Container _buildStatusLabel(MainModel model) {
    String text = 'Disconnected';
    Color textColor = Colors.red;
    if (model.isConnected) {
      text = 'Connected';
      textColor = Colors.green;
    } else {
      text = 'Disconnected';
      textColor = Colors.red;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Bracelet',
            style: TextStyle(fontSize: 12.0),
          ),
          Icon(
            Icons.watch,
            size: 22.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: textColor, borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              '$text',
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 67.0,
          ),
        ],
      ),
    );
  }

  Container _buildAvatarImage() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                print('gesture worked');
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey),
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/avatar4.png'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black38,
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              'Usain Salihov\n   25 years',
              style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'DroidSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 3.0,
          )
        ],
      ),
    );
  }

  Container _buildBatteryLabel(TraineeData data) {
    return Container(
      padding: EdgeInsets.only(right: 8.0, left: 12.0),
      child: Column(
        children: <Widget>[
          Text(
            'Battery',
            style: TextStyle(fontSize: 12.0),
          ),
          Icon(
            Icons.battery_charging_full,
            size: 22.0,
          ),
          Text(
                '${data.batteryLevel.toString()}%',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(
            height: 70.0,
          )
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
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
            title: Text('My coach info'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/trainee/coach/info'),
          ),
          ListTile(
            leading: Icon(Icons.check_box),
            title: Text('View coaches'),
            onTap: () => Navigator.pushNamed(context, '/trainee/coach/chose'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
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
        drawer: _buildDrawer(),
        appBar: AppBar(
          title: Text('Home page'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bluetooth');
              },
              icon: Icon(Icons.bluetooth),
            )
          ],
        ),
        body: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          model.userIdBluetooth = 1;
          return ListView(
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.green, Colors.black26],
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildBatteryLabel(model.data),
                          _buildAvatarImage(),
                          _buildStatusLabel(model),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    // _buildMotivationField(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 20.0),
                      margin: EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 0.0, bottom: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            new Color(0xff006B38),
                            new Color(0xff101820),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildStepsCounterField(model.data),
                          _buildMetersCounterField(model.data),
                          _buildCaloriesCounterField(model.data),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.black12, Colors.green],
                        ),
                      ),
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Activity:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Time:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider(),
                          _buildWalkingField(model.data),
                          Divider(),
                          _buildRunningField(model.data),
                          Divider(),
                          _buildCyclingField(model.data),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      );
    } else if (_selectedIndex == 1) {
      return TraineeStatPage();
    } else if (_selectedIndex == 2) {
      return TraineeGoalsPage();
    }
  }
}
