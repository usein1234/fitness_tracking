import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_trainee.dart';
import 'trainee_steps_page.dart';
import 'trainee_goals_page.dart';
import 'trainee_meters_page.dart';
import 'trainee_calories_page.dart';
import '../scoped_models/main_model.dart';

class TraineeStatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TraineeStatPageState();
  }
}

class _TraineeStatPageState extends State<TraineeStatPage>  {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index, MainModel model) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
//    final double deviceWidth = MediaQuery.of(context).size.width;
//    final double deviceHeight = MediaQuery.of(context).size.height;
    if (_selectedIndex == 1) {
      return DefaultTabController(
        length: 3,
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
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
              onTap: (int number) => _onItemTapped(number, model),
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
                    onTap: () => Navigator.pushReplacementNamed(context, '/trainee/info'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_pin),
                    title: Text('Coach info'),
                    onTap: () => Navigator.pushReplacementNamed(context, '/trainee/coach/info'),
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
            ),
            appBar: AppBar(
              title: Text('Trainee Statistics'),
              bottom: TabBar(
                labelColor: Colors.white,
                tabs: [
                  Tab(text: 'Steps', icon: Icon(Icons.directions_walk)),
                  Tab(text: 'Meters', icon: Icon(Icons.directions_run)),
                  Tab(text: 'Calories', icon: Icon(Icons.local_dining)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                StepsDataPage(),
                MetersDataPage(),
                CaloriesDataPage(),
              ],
            ),
          );
        }),
      );
    } else if (_selectedIndex == 0) {
      return HomeTraineePage();
    } else if (_selectedIndex == 2) {
      return TraineeGoalsPage();
    }
  }
}
