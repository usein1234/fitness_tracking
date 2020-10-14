import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../entity/trainee.dart';
import '../scoped_models/user_model.dart';

class CoachSelectPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CoachSelectPageState();
  }
}

class _CoachSelectPageState extends State<CoachSelectPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Chose your coach'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              CoachContainer(index), itemCount: 3,
        ));
  }
}

class CoachContainer extends StatelessWidget {
  final List<String> test =  ['One', 'Two', 'Three'];
  final int index;

  CoachContainer(this.index);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Text(test[index]),
          RaisedButton(onPressed: () => Navigator.pushNamed(context, '/bluetooth'))
        ],
      ),
    );
  }
}
