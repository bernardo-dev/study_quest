import 'package:flutter/material.dart';

class AppointmentState with ChangeNotifier {
  String _subject = '';
  String get subject => _subject;

  void setSubject(String value) {
    _subject = value;
    notifyListeners();
  }
}
