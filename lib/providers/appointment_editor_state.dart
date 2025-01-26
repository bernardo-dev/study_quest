import 'package:flutter/material.dart';

class AppointmentState with ChangeNotifier {
  String _subject = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(hours: 1));
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
  Color _color = Colors.lightBlue; // Default color

  bool _isAllDay = false;

  String _notes = '';

  final List<Color> _colorCollection = [
    const Color(0xFF0F8644),
    const Color(0xFF8B1FA9),
    const Color(0xFFD20100),
    const Color(0xFFFC571D),
    const Color(0xFF85461E),
    const Color(0xFFFF00FF),
    const Color(0xFF3D4FB5),
    const Color(0xFFE47C73),
    const Color(0xFF636363),
  ];

  final List<String> _colorNames = [
    'Verde',
    'Roxo',
    'Vermelho',
    'Laranja',
    'Caramelo',
    'Magenta',
    'Azul',
    'Pêssego',
    'Cinza',
  ];

  late final Color _selectedColor;

  AppointmentState() {
    _selectedColor = _colorCollection[0];
  }

  DateTime get startDate => _startDate;
  TimeOfDay get startTime => _startTime;
  DateTime get endDate => _endDate;
  TimeOfDay get endTime => _endTime;
  bool get isAllDay => _isAllDay;
  String get subject => _subject;
  String get notes => _notes;
  Color get color => _color;
  List<Color> get colorCollection => _colorCollection;
  List<String> get colorNames => _colorNames;
  Color get selectedColor => _selectedColor;

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

  void setColor(Color value) {
    _color = value;
    notifyListeners();
  }

  void setSelectedColor(Color value) {
    _selectedColor = value;
    notifyListeners();
  }
}
