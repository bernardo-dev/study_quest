import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/progress_data.dart';

class ProgressRepository {
  List<ProgressData> _progressData = [];

  Future<void> loadProgressData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? progressString = prefs.getString('progressData');
    if (progressString != null) {
      _progressData = List<Map<String, dynamic>>.from(json.decode(progressString))
          .map((data) => ProgressData.fromJson(data))
          .toList();
    } else {
      // Mock data for the last 3 days
      final now = DateTime.now();
      _progressData = [
        ProgressData(now.subtract(Duration(days: 3)).toString().split(' ')[0], 1.5),
        ProgressData(now.subtract(Duration(days: 2)).toString().split(' ')[0], 2.0),
        ProgressData(now.subtract(Duration(days: 1)).toString().split(' ')[0], 2.5),
      ];
      saveProgressData();
    }
  }

  Future<void> saveProgressData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('progressData', json.encode(_progressData));
  }

  List<ProgressData> getProgressData() {
    return _progressData;
  }

  void addProgressData(ProgressData data) {
    final int index = _progressData.indexWhere((d) => d.date == data.date);
    if (index != -1) {
      _progressData[index] = data;
    } else {
      _progressData.add(data);
    }
    saveProgressData();
  }

  Future<double> getTimeSpentToday() async {
    final prefs = await SharedPreferences.getInstance();
    final String today = DateTime.now().toString().split(' ')[0];
    final String? progressString = prefs.getString('progressData');
    if (progressString != null) {
      final List<ProgressData> progressData = List<Map<String, dynamic>>.from(json.decode(progressString))
          .map((data) => ProgressData.fromJson(data))
          .toList();
      final ProgressData? todayData = progressData.firstWhere(
        (data) => data.date == today,
        orElse: () => ProgressData(today, 0.0),
      );
      return todayData?.timeSpent ?? 0.0;
    }
    return 0.0;
  }

  Future<void> saveTimeSpentToday(double timeSpentToday) async {
    final prefs = await SharedPreferences.getInstance();
    final String today = DateTime.now().toString().split(' ')[0];
    final ProgressData todayData = ProgressData(today, timeSpentToday);
    addProgressData(todayData);
  }
}