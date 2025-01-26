import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class AppointmentDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getAppointmentData(index).startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return _getAppointmentData(index).endTime;
  }

  @override
  String getSubject(int index) {
    return _getAppointmentData(index).subject;
  }

  @override
  Color getColor(int index) {
    return _getAppointmentData(index).color;
  }

  @override
  bool isAllDay(int index) {
    return _getAppointmentData(index).isAllDay;
  }

  Appointment _getAppointmentData(int index) {
    final Appointment appointment = appointments![index] as Appointment;

    return appointment;
  }
}
