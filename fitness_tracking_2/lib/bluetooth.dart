import 'dart:core';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:fitness_tracking_2/bluetooth_module/scan_results.dart';



import 'scoped_models/main_model.dart';

class BluetoothPageResults extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BluetoothPageState();
  }
}

class _BluetoothPageState extends State<BluetoothPageResults> {
  //SCANNING BUTTON
  _buildScanningButton(MainModel model) {
    if (model.isConnected || model.state != BluetoothState.on) {
      return null;
    }
    if (model.isScanning) {
      //if it is scanning change button
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: () => model.stopScan(),
        backgroundColor: Colors.red,
      );
    } else {
      return new FloatingActionButton(
          child: new Icon(Icons.search), onPressed: () => model.startScan());
    }

  }

  //scan results
  _buildScanResultTiles(MainModel model) {
    return model.scanResults.values
        .map((r) => ScanResultTile(
              result: r,
              onTap: () => model.connect(r.device),
            ))
        .toList();
  }

  _buildActionButtons(MainModel model) {
    if (model.isConnected) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => model.disconnect(),
        )
      ];
    }
  }

  _buildAlertTile(MainModel model) {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${model.state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildDeviceStateTile(MainModel model) {
    return new ListTile(
        leading: (model.deviceState == BluetoothDeviceState.connected)
            ? const Icon(Icons.bluetooth_connected)
            : const Icon(Icons.bluetooth_disabled),
        title: new Text(
            'Device is ${model.deviceState.toString().split('.')[1]}.'),
        subtitle: new Text('${model.device.id}'),
        trailing: new IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => model.refreshDeviceState(model.device),
          color: Theme.of(context).iconTheme.color.withOpacity(0.5),
        ));
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  bool isScanning() {
    bool isScan = false;
    ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      model.isScanning = isScan;
    });
    return isScan;
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      model.init();
      if (model.state != BluetoothState.on) {
        return Scaffold(
          appBar: new AppBar(
            title: const Text('Bluetooth'),
            actions: _buildActionButtons(model),
          ),
          floatingActionButton: _buildScanningButton(model),
          body: new Stack(
            children: <Widget>[
              (model.isScanning) ? _buildProgressBarTile() : new Container(),
              new ListView(
                children: <Widget>[_buildAlertTile(model)],
              ),
            ],
          ),
        );
      }
      if (model.isConnected) {
        return Scaffold(
          appBar: new AppBar(
            title: const Text('Bluetooth'),
            actions: _buildActionButtons(model),
          ),
          floatingActionButton: _buildScanningButton(model),
          body: new Stack(
            children: <Widget>[
              (model.isScanning) ? _buildProgressBarTile() : new Container(),
              new ListView(
                children: <Widget>[
                  _buildDeviceStateTile(model),
                ],
              )
            ],
          ),
        );
        //   tiles.addAll(_buildServiceTiles());
      } else {
        return Scaffold(
          appBar: new AppBar(
            title: const Text('Bluetooth'),
            actions: _buildActionButtons(model),
          ),
          floatingActionButton: _buildScanningButton(model),
          body: new Stack(
            children: <Widget>[
              (model.isScanning) ? _buildProgressBarTile() : new Container(),
              new ListView(
                children: _buildScanResultTiles(model),
              )
            ],
          ),
        );
      }
    });
  }
}
