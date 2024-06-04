import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeProvider extends ChangeNotifier {

  final int goalSteps = 1000;
  int currentSteps = 100;

  final sensorChannel = const EventChannel('sensor');
  final double _threshold = 0;
  List<double> _previousEvent = [0.0, 0.0, 0.0];
  StreamSubscription? _subscription;

  void startListening() {
    _subscription = sensorChannel.receiveBroadcastStream().listen((event) {
      List<double> accelerometerValues = List<double>.from(event);
      double deltaX = accelerometerValues[0] - _previousEvent[0];
      double deltaY = accelerometerValues[1] - _previousEvent[1];
      double deltaZ = accelerometerValues[2] - _previousEvent[2];

      double magnitude = (deltaX * deltaX) + (deltaY * deltaY) + (deltaZ * deltaZ);
      if (magnitude > _threshold) {
        currentSteps++;
        notifyListeners();
      }
      _previousEvent = accelerometerValues;
    });
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}