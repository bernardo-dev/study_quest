import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/progress_repository.dart';
import '../models/progress_data.dart';
import 'subject_provider.dart';

class ProgressProvider with ChangeNotifier {
  final ProgressRepository _repository = ProgressRepository();
  List<ProgressData> _progressData = [];
  double _timeSpentToday = 0.0;
  Timer? _timer;

  ProgressProvider() {
    _loadProgressData();
  }

  List<ProgressData> get progressData {
    final String today = DateTime.now().toString().split(' ')[0];
    final List<ProgressData> updatedProgressData = List.from(_progressData);
    final int todayIndex = updatedProgressData.indexWhere((data) => data.date == today);

    if (todayIndex != -1) {
      updatedProgressData[todayIndex] = ProgressData(today, _timeSpentToday);
    } else {
      updatedProgressData.add(ProgressData(today, _timeSpentToday));
    }

    return updatedProgressData;
  }

  List<ProgressData>? get desiredStudyData => null;

  double getDesiredStudyTime(BuildContext context) {
    final subjects = Provider.of<SubjectProvider>(context, listen: false).subjects;
    final totalWeeklyHours = subjects.fold(0, (sum, subject) => sum + (subject['hours'] as int));
    return totalWeeklyHours / 7; // Média diária
  }

  List<ProgressData> getDesiredStudyData(BuildContext context) {
    final double desiredTime = getDesiredStudyTime(context);
    return progressData.map((data) => ProgressData(data.date, desiredTime)).toList();
  }

  void _loadProgressData() async {
    _timeSpentToday = await _repository.getTimeSpentToday();
    await _repository.loadProgressData();
    _progressData = _repository.getProgressData();
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      _timeSpentToday += 1 / 60; // Incrementa o tempo gasto em horas
      _repository.saveTimeSpentToday(_timeSpentToday); // Salva o tempo gasto hoje
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    final String today = DateTime.now().toString().split(' ')[0];
    _repository.addProgressData(ProgressData(today, _timeSpentToday));
    notifyListeners();
  }
}