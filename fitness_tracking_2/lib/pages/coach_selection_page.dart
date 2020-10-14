import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_model.dart';
import '../entity/coach.dart';

class CoachSelectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CoachSelectionPageState();
  }
}

class _CoachSelectionPageState extends State<CoachSelectionPage> {
  bool confirm = false;

  void _showDialog(int id, Function select) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text("You are about to chose new coach!!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Confirm"),
              onPressed: () {
                select(id);
                Navigator.pushReplacementNamed(context, '/trainee/coach/info');
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Coach selection'),
      ),
      body: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (model.requestStatus == 0) {
          model.getCoachList();
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) => CoachContainer(
              index, model.coachList, model.selectCoach, _showDialog),
          itemCount: model.coachList.length,
        );
      }),
    );
  }
}

class CoachContainer extends StatelessWidget {
  final List<Coach> coachList;
  final int index;
  final Function selectCoach;
  final Function showDialog;

  CoachContainer(this.index, this.coachList, this.selectCoach, this.showDialog);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.black12,
          border: Border.all(width: 2.0, color: Colors.black45)),
      margin: EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () => print('Hello'),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0)
                  //    border: Border.all(color: Colors.greenAccent),
                  ),
              margin: EdgeInsets.only(left: 90.0, bottom: 0.0),
              padding: EdgeInsets.only(top: 10.0, left: 8.0, bottom: 10.0),
              width: deviceWidth,
              height: 135.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 180.0,
                    margin: EdgeInsets.only(top: 0.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.black38),
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Name:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Text(
                              '${coachList[index].fullName}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.black38),
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Gender:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Text(
                              '${coachList[index].gender}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.black38),
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Area:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Text(
                              '${coachList[index].areaValue}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.black38),
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Exper:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Text(
                              '${coachList[index].expValue.toString()} years',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1.0))),
                    width: 88.0,
                    height: 200.0,
                    margin: EdgeInsets.only(left: 190.0, top: 0.0, bottom: 0.0),
                    padding: EdgeInsets.only(
                        left: 4.0, right: 5.0, top: 40.0, bottom: 45.0),
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () {
                        showDialog(coachList[index].id, selectCoach);
                        //  selectCoach(coachList[index].id);
                      },
                      child: Text(
                        'Chose',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: 3.0, right: 3.0, bottom: 3.0, top: 10.0),
            child: GestureDetector(
              onTap: () {
                print('gesture worked');
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green[300]),
                padding: EdgeInsets.all(0.0),
                child: CircleAvatar(
                  radius: 38.0,
                  backgroundImage:   NetworkImage('https://www.usys.ethz.ch/content/specialinterest/usys/d-usys/en/personen/profil.person_image.jpeg?persid=MjQzNjY5'),
                ),
              ),
            ),
          ),
          Container(
            height: 125.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.black38),
                  margin: EdgeInsets.only(left: 7.0),
                  child: Text(
                    'Rating: ${coachList[index].getScore.floor().toString()}/5',
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          ),

//          Padding(
//            padding: EdgeInsets.all(6.0),
//            child: Container(
//              padding: EdgeInsets.all(25.0),
//              decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  color: Colors.green,
//                  border: Border.all(color: Colors.black12, width: 2.0)),
//              child: Column(
//                children: <Widget>[_buildIcon(index), Text('cycling')],
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
