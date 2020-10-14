import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_model.dart';
import 'home_trainee.dart';
import 'package:fitness_tracking_2/pages/elements/day_chart.dart';
import 'package:fitness_tracking_2/pages/elements/bar_chart.dart';

class MetersDataPage extends StatelessWidget {
  _handleDateChose(BuildContext context) {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        if (model.statusPage2 == 0) {
          model.makeMetersRequest(1);
        }
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.black12,
              Colors.green[700],
            ],
          )),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: null),
                      Container(
                        margin: EdgeInsets.only(top: 6.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                            GestureDetector(
                              child: Text(
                                model.getDate(),
                                style: TextStyle(fontSize: 17.0),
                              ),
                              onTap: () => _handleDateChose(context),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: null)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.grey[700]),
                    width: deviceWidth,
                    height: deviceHeight * 0.38,
                    child: TimeSeriesBar(
                      model.createDataChart(model.chartMetersData),
                      animate: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25.0),
                    padding: EdgeInsets.only(top: 3.0, right: 3.0, bottom: 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black26),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black26))),
                          width: deviceWidth * 0.50,
                          padding: EdgeInsets.all(2.0),
                          margin: EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Meters: ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.5),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${model.sumMeters}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black26))),
                          width: deviceWidth * 0.50,
                          margin: EdgeInsets.only(left: 8.0),
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Walking: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '${model.walking.inHours}h ${model.walking.inMinutes}m',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black26))),
                          width: deviceWidth * 0.50,
                          margin: EdgeInsets.only(left: 8.0),
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Running:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '${model.running.inHours}h ${model.running.inMinutes}m',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: deviceWidth * 0.50,
                          margin: EdgeInsets.only(left: 8.0),
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Cycling:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '${model.cycling.inHours}h ${model.cycling.inMinutes}m',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 35.0,
                  ),
                  FlatButton(
                    onPressed: () {
                      model.getMonthMetersData();
                      Navigator.pushNamed(context, '/trainee/stat/meters');
                    },
                    child: Text('Month stats'),
                    color: Colors.grey[600],
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    width: 2.0,
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
