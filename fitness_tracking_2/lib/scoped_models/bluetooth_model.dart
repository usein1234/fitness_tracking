import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


import 'package:flutter_blue/flutter_blue.dart';

import '../entity/trainee_data.dart';

var urlEmulator = 'http://10.0.2.2:3000';
var urlAndroidDevice = 'http://localhost:3000';

class BluetoothModel extends Model {
  int userIdBluetooth = 0;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  String serviceUUID = "6e400000-b5a3-f393-e0a9-e50e24dcca9d";
  String dataUUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9d";
  TraineeData data = new TraineeData(
      steps: 0,
      meters: 0,
      batteryLevel: 0,
      trainingMode: 'walking',
      calories: 0.0,
      cyclingMinutes: 0,
      runningMinutes: 0,
      walkingMinutes: 0);
  int batteryPercentage = 0;
  BluetoothCharacteristic changingData;

  //CounterStorage writeData = new CounterStorage();

  /// Scanning
  StreamSubscription _scanSubscription;

  //scan results
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();

  //scan changes state
  bool isScanning = false;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  /// Device
  BluetoothDevice device;

  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;

  //Services
  List<BluetoothService> services = new List();
  Map<Guid, StreamSubscription> valueChangedSubscriptions = {};
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  init() {
    flutterBlue.state.then((s) {
      state = s;
    });
    notifyListeners();
// Subscribe to state changes
    _stateSubscription = flutterBlue.onStateChanged().listen((s) {
      state = s;
    });
    notifyListeners();
  }

  startScan() {
    _scanSubscription = flutterBlue
        .scan(
      timeout: const Duration(seconds: 5),
    )
        .listen((scanResult) {
      print('localName: ${scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${scanResult.advertisementData.serviceData}');
      scanResults[scanResult.device.id] = scanResult;
      notifyListeners();
    }, onDone: stopScan);
    isScanning = true;
    notifyListeners();
  }

  stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    isScanning = false;
    notifyListeners();
  }

  connect(BluetoothDevice d) async {
    device = d;
// Connect to device
    deviceConnection =
        flutterBlue.connect(device, timeout: const Duration(seconds: 4)).listen(
              null,
              onDone: disconnect,
            );

    // Update the connection state immediately
    device.state.then((s) {
      deviceState = s;
      notifyListeners();
    });

    // Subscribe to connection changes
    deviceStateSubscription = device.onStateChanged().listen((s) {
      deviceState = s;
      notifyListeners();

      // If it is connected discover services
      if (s == BluetoothDeviceState.connected) {
        device.discoverServices().then((s) {
          services = s;
          _extractData();
          _setNotification(changingData);
          notifyListeners();
        });
      }
    });
  }

  disconnect() {
// Remove all value changed listeners
    valueChangedSubscriptions.forEach((uuid, sub) => sub.cancel());
    valueChangedSubscriptions.clear();
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    device = null;
    notifyListeners();
  }

  _setNotification(BluetoothCharacteristic c) async {
    print("Notify:${c.uuid}");
    if (c.isNotifying) {
      await device.setNotifyValue(c, false);
// Cancel subscription
      valueChangedSubscriptions[c.uuid]?.cancel();
      valueChangedSubscriptions.remove(c.uuid);
    } else {
      await device.setNotifyValue(c, true);
// ignore: cancel_subscriptions
      final sub = device.onValueChanged(c).listen((d) {
        print('Characteristic id: ${c.uuid.toString()}');
        print('onValueChanged: $d');
        var date = DateTime.now();
        print('${date.hour}:${date.minute}:${date.second}');
        handleDataChange(c);
        notifyListeners();
      });
// Add to map
      valueChangedSubscriptions[c.uuid] = sub;
    }
    notifyListeners();
  }

  refreshDeviceState(BluetoothDevice d) async {
    var state = await d.state;
    deviceState = state;
    print('State refreshed: $deviceState');
    notifyListeners();
  }

  _extractData() {
    for (var service in services) {
      if (service.uuid.toString() == serviceUUID) {
        print('Match service..');
        for (var charac in service.characteristics) {
          if (charac.uuid.toString() == dataUUID) {
            print('Match characteristics..');
            changingData = charac;
          }
        }
      }
    }
  }

  handleDataChange(BluetoothCharacteristic c) async {
    if (c.value.length == 4) {
      batteryPercentage = c.value[2];
    } else {
      if (c.uuid.toString() == dataUUID) {
        data.updateData(
            meters: c.value[7],
            steps: c.value[6],
            calories: c.value[9],
            trainingMode: c.value[5],
            batteryLevel: batteryPercentage);
        data.show();
      }
      saveActivityData();
      //request
    }
  }

  saveActivityData() async {
    data.userId = userIdBluetooth;
    var reqResponse = await http.post(
      urlAndroidDevice + '/trainee/activity', body: data.toMap());
    var response = await json.decode(reqResponse.body);
    print('braclete data:');
    print(response);
  }
}
