import 'package:flutter/material.dart';

class System with ChangeNotifier {
  String _systemStatus = "STOP";

  String get systemStatus => _systemStatus;

  void stopSystem() {
    _systemStatus = 'STOP';
    notifyListeners();
  }

  void startSystem() {
    _systemStatus = 'RUNNING';
    notifyListeners();
  }
}
