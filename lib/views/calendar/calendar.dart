import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:study_quest/widgets/app_drawer.dart';
import 'package:study_quest/providers/appointment_data_source.dart';

/// The hove page which hosts the calendar
class CalendarPage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String selectedPage = 'Página Inicial';

  CalendarController calendarController = CalendarController();

  List<Color> _colorCollection = <Color>[];
  List<String> _colorNames = <String>[];
  int _selectedColorIndex = 0;
  int _selectedTimeZoneIndex = 0;
  List<String> _timeZoneCollection = <String>[];
  late AppointmentDataSource _events;
  Appointment? _selectedAppointment;
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  bool _isAllDay = false;
  String _subject = '';
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        controller: calendarController,
        showNavigationArrow: true,
        dataSource: AppointmentDataSource(_getDataSource()),
        // by default the month appointment display mode set as Indicator, we can
        // change the display mode as appointment using the appointment display
        // mode property
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        allowedViews: [
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek,
          CalendarView.timelineMonth,
          CalendarView.schedule
        ],
        allowDragAndDrop: true,
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            final Appointment appointment = details.appointments![0];
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(appointment.subject),
                content: Column(
                  children: <Widget>[
                    Text('Início: ${appointment.startTime}'),
                    Text('Fim: ${appointment.endTime}'),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Fechar'),
                  ),
                ],
              ),
            );
          } else {}
        },
      ),
      appBar: AppBar(
        title: Text(selectedPage),
      ),
      drawer: AppDrawer(
        selectedPage:
            selectedPage, // Passando a página selecionada para o Drawer
        onItemSelected: (String page) {
          setState(() {
            selectedPage = page;
          });
        },
      ),
    );
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';

      // Checks the current view of the calendar. If the view is set to
      // CalendarView.month, it changes the view to CalendarView.day.
      // This allows the user to see more details about the selected date.
      if (calendarController.view == CalendarView.month) {
        calendarController.view = CalendarView.day;
      } else {
        // If the tapped element is an appointment, the details of the
        // appointment are displayed.
        // Else the tapped date and time are displayed.
        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final Appointment appointmentDetails =
              calendarTapDetails.appointments![0];
          _startDate = appointmentDetails.startTime;
          _endDate = appointmentDetails.endTime;
          _isAllDay = appointmentDetails.isAllDay;
          _selectedColorIndex =
              _colorCollection.indexOf(appointmentDetails.color);
          _selectedTimeZoneIndex = appointmentDetails.startTimeZone == ''
              ? 0
              : _timeZoneCollection
                  .indexOf(appointmentDetails.startTimeZone ?? '');
          _subject = appointmentDetails.subject == '(No title)'
              ? ''
              : appointmentDetails.subject;
          _notes = appointmentDetails.notes ?? '';
          _selectedAppointment = appointmentDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(const Duration(hours: 1));
        }
        _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AppointmentEditor()))
      }
    });
  }

  // ignore: just for test
  List<Appointment> _getDataSource() {
    final List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Appointment(subject: 'Teste', startTime: startTime, endTime: endTime));
    return meetings;
  }
}
