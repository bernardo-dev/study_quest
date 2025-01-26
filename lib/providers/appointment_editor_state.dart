import 'package:flutter/material.dart';

class AppointmentState with ChangeNotifier {
  List<Color> _colorCollection = <Color>[];
  List<String> _colorNames = <String>[];
  int _selectedColorIndex = 0;
  int _selectedTimeZoneIndex = 0;
  List<String> _timeZoneCollection = <String>[];
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  bool _isAllDay = false;
  String _subject = '';
  String _notes = '';

  List<Color> get colorCollection => _colorCollection;
  List<String> get colorNames => _colorNames;
  int get selectedColorIndex => _selectedColorIndex;
  int get selectedTimeZoneIndex => _selectedTimeZoneIndex;
  List<String> get timeZoneCollection => _timeZoneCollection;

  DateTime get startDate => _startDate;
  TimeOfDay get startTime => _startTime;
  DateTime get endDate => _endDate;
  TimeOfDay get endTime => _endTime;
  bool get isAllDay => _isAllDay;
  String get subject => _subject;
  String get notes => _notes;

  void setColorCollection(List<Color> value) {
    _colorCollection = value;
    notifyListeners();
  }

  void setColorNames(List<String> value) {
    _colorNames = value;
    notifyListeners();
  }

  void setSelectedColorIndex(int value) {
    _selectedColorIndex = value;
    notifyListeners();
  }

  void setSelectedTimeZoneIndex(int value) {
    _selectedTimeZoneIndex = value;
    notifyListeners();
  }

  void setTimeZoneCollection(List<String> value) {
    _timeZoneCollection = value;
    notifyListeners();
  }

  void setStartDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  void setStartTime(TimeOfDay value) {
    _startTime = value;
    notifyListeners();
  }

  void setEndDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  void setEndTime(TimeOfDay value) {
    _endTime = value;
    notifyListeners();
  }

  void setAllDay(bool value) {
    _isAllDay = value;
    notifyListeners();
  }

  void setSubject(String value) {
    _subject = value;
    notifyListeners();
  }

  void setNotes(String value) {
    _notes = value;
    notifyListeners();
  }
}
