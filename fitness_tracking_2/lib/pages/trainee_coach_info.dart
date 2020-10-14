import 'package:scoped_model/scoped_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import '../scoped_models/main_model.dart';

class TraineeCoachInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Coach info'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Chose'),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home page'),
              onTap: () => Navigator.pushReplacementNamed(context, '/trainee'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal info'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/trainee/info'),
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
        model.getCoachInfo(1);
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.green,
                  Colors.black45,
                ],
              ),
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.black12,
              border: Border.all(width: 2.0, color: Colors.black54)),
          margin: EdgeInsets.only(bottom: 0.0, left: 0.0, right: 0.0, ),
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26, width: 3.0)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://www.usys.ethz.ch/content/specialinterest/usys/d-usys/en/personen/profil.person_image.jpeg?persid=MjQzNjY5'),
                  backgroundColor: Colors.black12,
                  radius: 55.0,
                ),
              ),
              SizedBox(height: 8.0,),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5.0)),
                child: Column(
                  children: <Widget>[
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
                        Text('${model.traineeCoach.fullName}',
                            style: TextStyle(fontSize: 16.0)),
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
                            new Text('Email: ',
                                style: TextStyle(fontSize: 16.0))
                          ],
                        ),
                        Text('${model.traineeCoach.email}',
                            style: TextStyle(fontSize: 16.0)),
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
                        Text('${model.traineeCoach.age}',
                            style: TextStyle(fontSize: 16.0)),
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
                            new Text('Gender: ',
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        new Text('${model.traineeCoach.gender}',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Icon(Icons.work),
                            SizedBox(
                              width: 5.0,
                            ),
                            new Text('Area: ',
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        Text('${model.traineeCoach.areaValue}',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Icon(Icons.explicit),
                            SizedBox(
                              width: 5.0,
                            ),
                            new Text('Exper: ',
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        new Text('${model.traineeCoach.expValue} years',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Icon(Icons.rate_review),
                            SizedBox(
                              width: 5.0,
                            ),
                            new Text('Rating: ',
                                style: TextStyle(fontSize: 16.0)),
                          ],
                        ),
                        new Text('${model.traineeCoach.getScore}/5.0',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
