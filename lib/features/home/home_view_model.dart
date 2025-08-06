import 'package:flutter/material.dart';

class Alarm {
  final DateTime time;
  
  Alarm(this.time);
}

class HomeViewModel extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  void addAlarm(DateTime time) {
    _alarms.add(Alarm(time));
    _alarms.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  void removeAlarm(int index) {
    _alarms.removeAt(index);
    notifyListeners();
  }
}