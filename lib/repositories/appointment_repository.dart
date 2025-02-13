import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppointmentRepository {
  List<Map<String, dynamic>> _appointments = [];

  Future<List<Map<String, dynamic>>> loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? appointmentsString = prefs.getString('appointments');
    if (appointmentsString != null) {
      _appointments = List<Map<String, dynamic>>.from(json.decode(appointmentsString));
    }
    return _appointments;
  }

  Future<void> saveAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appointments', json.encode(_appointments));
  }

  void addAppointment({
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required Color color,
    required String startTimeZone,
    required String endTimeZone,
    required String notes,
    required bool isAllDay,
  }) {
    _appointments.add({
      'subject': subject,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'color': color.value,
      'startTimeZone': startTimeZone,
      'endTimeZone': endTimeZone,
      'notes': notes,
      'isAllDay': isAllDay,
    });
    saveAppointments();
  }

  void deleteAppointment(Map<String, dynamic> appointment) {
    _appointments.remove(appointment);
    saveAppointments();
  }

  void updateAppointment(
    Map<String, dynamic> appointment, {
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required Color color,
    required String startTimeZone,
    required String endTimeZone,
    required String notes,
    required bool isAllDay,
  }) {
    appointment['subject'] = subject;
    appointment['startTime'] = startTime.toIso8601String();
    appointment['endTime'] = endTime.toIso8601String();
    appointment['color'] = color.value;
    appointment['startTimeZone'] = startTimeZone;
    appointment['endTimeZone'] = endTimeZone;
    appointment['notes'] = notes;
    appointment['isAllDay'] = isAllDay;
    saveAppointments();
  }
}