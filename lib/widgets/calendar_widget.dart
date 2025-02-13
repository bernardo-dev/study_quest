import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_quest/models/event_data_source.dart';
import 'package:study_quest/pages/event_editing_page.dart';
import 'package:study_quest/pages/event_viewing_page.dart';
import 'package:study_quest/providers/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      allowAppointmentResize: false,
      allowDragAndDrop: false,
      view: CalendarView.week,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      allowedViews: [
        CalendarView.week,
        CalendarView.timelineWeek,
        CalendarView.month
      ],
      // celula vazia: CalendarElement.calendarCell
      onTap: (calendarTapDetails) {
        if (calendarTapDetails.targetElement == CalendarElement.appointment) {
          // se clicar em um evento
          final event = calendarTapDetails.appointments![0];
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventViewingPage(event: event)));
        } else if (calendarTapDetails.targetElement ==
            CalendarElement.calendarCell) {
          // se clicar em uma celula vazia
          print('clicou em uma celula vazia');
          print(calendarTapDetails.date);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  EventEditingPage(details: calendarTapDetails)));
        }
      },
    );
  }
}
