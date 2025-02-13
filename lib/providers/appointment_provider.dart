import 'package:flutter/material.dart';
import '../repositories/appointment_repository.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentRepository _repository;

  AppointmentProvider(this._repository) {
    _loadAppointments();
  }

  List<Map<String, dynamic>> _appointments = [];

  List<Map<String, dynamic>> get appointments => _appointments;

  Future<void> _loadAppointments() async {
    _appointments = await _repository.loadAppointments();
    notifyListeners();
  }

  Future<void> loadAppointments() async {
    await _loadAppointments();
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
    _repository.addAppointment(
      subject: subject,
      startTime: startTime,
      endTime: endTime,
      color: color,
      startTimeZone: startTimeZone,
      endTimeZone: endTimeZone,
      notes: notes,
      isAllDay: isAllDay,
    );
    _loadAppointments();
  }

  void deleteAppointment(Map<String, dynamic> appointment) {
    _repository.deleteAppointment(appointment);
    _loadAppointments();
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
    _repository.updateAppointment(
      appointment,
      subject: subject,
      startTime: startTime,
      endTime: endTime,
      color: color,
      startTimeZone: startTimeZone,
      endTimeZone: endTimeZone,
      notes: notes,
      isAllDay: isAllDay,
    );
    _loadAppointments();
  }
}