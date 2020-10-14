import 'package:flutter/material.dart';
import 'package:fitness_tracking_2/pages/elements/bar_chart.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_model.dart';

class TraineeMetersDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Month details'),
        centerTitle: true,
      ),
      body:
      ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_back),
                  SizedBox(
                    width: 2.0,
                  ),
                  Container(
                    margin: EdgeInsets.only( bottom: 6.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${model.yearMonthDate}',
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(3.0)),
              height: 250.0,
              child: TimeSeriesBar(
                model.createDataChart(model.chartMetersDataMonth),
                animate: true,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Colors.black12, Colors.green],
                ),
              ),
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.0),
                    padding: EdgeInsets.all(2.0),
                    width: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(3.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.directions_walk),
                        Text(
                          'Meters statistics:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Average meters:',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Container(
                        child: Text('${model.avg_meters.floor().toString()}', style: TextStyle(fontSize: 15.0)),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child:
                        Text('Max meters:', style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        child: Text('${model.max_meters.toString()}', style: TextStyle(fontSize: 15.0)),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child:
                        Text('All Meters:', style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        child: Text('${model.all_meters.toString()}', style: TextStyle(fontSize: 15.0)),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text('Activity time:',
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        child:
                        Text('${model.activityTime.inHours}h ${model.activityTime.inMinutes} m', style: TextStyle(fontSize: 15.0)),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ],
        );
      }),


    );
  }
}
