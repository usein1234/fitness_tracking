import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../entity/trainee.dart';
import '../scoped_models/main_model.dart';
import 'create_goals.dart';
import 'coach_progress.page.dart';

class HomeCoachPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeCoachPageState();
  }
}

class _HomeCoachPageState extends State<HomeCoachPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Trainee list'),
      ),
      floatingActionButton:
      ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
       return FloatingActionButton(
          onPressed: () => model.getCoachTrainees(),
          child: Icon(Icons.refresh),
          backgroundColor: Colors.lightGreen,
        );
      }),
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
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
          ],
        ),
      ),
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (model.traineeList.length == 0) {
          return new Column(
            children: <Widget>[
              Center(
                child: Text('Loading...'),
              )
            ],
          );
        } else {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                CoachContainer(model.traineeList, index),
            itemCount: model.traineeList.length,
          );
        }
      }),
    );
  }
}

class CoachContainer extends StatelessWidget {
  final int index;
  final List<Trainee> traineeList;

  CoachContainer(this.traineeList, this.index);

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.green,
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black26, width: 3.0)),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://www.usys.ethz.ch/content/specialinterest/usys/d-usys/en/personen/profil.person_image.jpeg?persid=MjQzNjY5'),
                    backgroundColor: Colors.black12,
                    radius: 55.0,
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        new Icon(Icons.info),
                        SizedBox(
                          width: 5.0,
                        ),
                        new Text(
                          'Name: ',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                    Text('${traineeList[index].fullName}', style: TextStyle(fontSize: 16.0)),

                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        new Icon(Icons.email),
                        SizedBox(
                          width: 5.0,
                        ),
                        new Text('Email: ', style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                    Text('${traineeList[index].email}', style: TextStyle(fontSize: 16.0)),

                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        new Icon(Icons.language),
                        SizedBox(
                          width: 5.0,
                        ),
                        new Text('Age: ', style: TextStyle(fontSize: 16.0))
                      ],
                    ),
                    Text('${traineeList[index].age.toString()}', style: TextStyle(fontSize: 16.0)),

                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        new Icon(FontAwesomeIcons.genderless),
                        SizedBox(
                          width: 5.0,
                        ),
                        new Text('Gender: ', style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    new Text('${traineeList[index].gender}', style: TextStyle(fontSize: 16.0)),

                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        new Icon(Icons.format_align_justify),
                        SizedBox(
                          width: 5.0,
                        ),
                        new Text('Height: ', style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    Text('${traineeList[index].getHeight.toString()} ${traineeList[index].getHeightUnit}', style: TextStyle(fontSize: 16.0)),

                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        new Icon(FontAwesomeIcons.weight),
                        SizedBox(
                          width: 5.0,
                        ),
                        new Text('Weight: ', style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    new Text('${traineeList[index].getWeight.toString()} ${traineeList[index].getWeightUnit}', style: TextStyle(fontSize: 16.0)),

                  ],
                ),
              ],
            ),
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: InkWell(
          onTap: () => _settingModalBottomSheet(context),
          child: Container(
            child: ListTile(
              trailing: Icon(FontAwesomeIcons.male),
              leading: Container(
                decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.greenAccent, width: 2.0)),
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://www.usys.ethz.ch/content/specialinterest/usys/d-usys/en/personen/profil.person_image.jpeg?persid=MjQzNjY5'),
                ),
              ),
              title: Text('${traineeList[index].fullName}'),
              subtitle: Text('Age: ${traineeList[index].age}'),
            ),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Create goal',
            color: Colors.blue,
            icon: Icons.today,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> GoalsCreatePage(index, traineeList[index].fullName))),
          ),
          IconSlideAction(
            caption: 'Progress',
            color: Colors.indigo,
            icon: Icons.data_usage,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> CoachProgressPage(index))),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Details',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => _settingModalBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
