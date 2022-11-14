import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class System with ChangeNotifier {
  String _systemStatus = "STOP";

  String get systemStatus => _systemStatus;

  void stopSystem() {
    _systemStatus = 'STOP';
  }

  void startSystem() {
    _systemStatus = 'RUNNING';
  }
}
