import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:study_quest/models/event.dart';
import 'package:intl/intl.dart';
import 'package:study_quest/providers/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;
  final CalendarTapDetails? details;

  const EventEditingPage({
    Key? key,
    this.event,
    this.details,
  });

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late bool isAllDay;

  @override
  void initState() {
    super.initState();

    // If the user clicked on a date in the calendar or the Floating Action Button
    if (widget.event == null) {
      if (widget.details != null && widget.details!.date != null) {
        fromDate = widget.details!.date!;
      } else {
        fromDate = DateTime.now();
      }
      // fromDate = widget.details!.date!;
      toDate = fromDate.add(const Duration(hours: 1));
      isAllDay = false;
    } else if (widget.event != null) {
      final event = widget.event!;

      titleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
      isAllDay = event.isAllDay;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              buildTitle(),
              // diatodo
              buildDivider(),
              buildFrom(),
              buildTo(),
            ],
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        IconButton(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          icon: Icon(Icons.done),
          onPressed: saveForm,
        ),
      ];

  Widget buildTitle() => ListTile(
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Adicionar Título',
          ),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
          onFieldSubmitted: (_) => saveForm(),
          controller: titleController,
        ),
      );

  Widget buildDivider() => Divider(thickness: 1, height: 1);

  Widget buildFrom() => ListTile(
        leading: Text(''),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: GestureDetector(
                child: Text(
                  DateFormat('EEE, MMM dd yyyy').format(fromDate),
                  textAlign: TextAlign.left,
                ),
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: fromDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (date != null && date != fromDate) {
                    setState(() {
                      fromDate = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        fromDate.hour,
                        fromDate.minute,
                      );
                      if (fromDate.isAfter(toDate)) {
                        toDate = fromDate.add(const Duration(hours: 1));
                      }
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: isAllDay
                  ? const Text('')
                  : GestureDetector(
                      child: Text(
                        DateFormat('hh:mm a').format(fromDate),
                        textAlign: TextAlign.right,
                      ),
                      onTap: () async {
                        final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: fromDate.hour, minute: fromDate.minute));

                        if (time != null &&
                            (time.hour != fromDate.hour ||
                                time.minute != fromDate.minute)) {
                          setState(() {
                            fromDate = DateTime(
                              fromDate.year,
                              fromDate.month,
                              fromDate.day,
                              time.hour,
                              time.minute,
                            );
                            if (fromDate.isAfter(toDate)) {
                              toDate = fromDate.add(const Duration(hours: 1));
                            }
                          });
                        }
                      },
                    ),
            ),
          ],
        ),
      );

  Widget buildTo() => ListTile(
        leading: Text(''),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: GestureDetector(
                child: Text(
                  DateFormat('EEE, MMM dd yyyy').format(toDate),
                  textAlign: TextAlign.left,
                ),
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: toDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (date != null && date != toDate) {
                    setState(() {
                      toDate = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        toDate.hour,
                        toDate.minute,
                      );
                      if (toDate.isBefore(fromDate)) {
                        fromDate = toDate.subtract(const Duration(hours: 1));
                      }
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: isAllDay
                  ? const Text('')
                  : GestureDetector(
                      child: Text(DateFormat('hh:mm a').format(toDate),
                          textAlign: TextAlign.right),
                      onTap: () async {
                        final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: toDate.hour, minute: toDate.minute));
                        if (time != null &&
                            (time.hour != toDate.hour ||
                                time.minute != toDate.minute)) {
                          setState(() {
                            toDate = DateTime(
                              toDate.year,
                              toDate.month,
                              toDate.day,
                              time.hour,
                              time.minute,
                            );
                            if (toDate.isBefore(fromDate)) {
                              fromDate =
                                  toDate.subtract(const Duration(hours: 1));
                            }
                          });
                        }
                      },
                    ),
            ),
          ],
        ),
      );

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: '',
        from: fromDate,
        to: toDate,
        isAllDay: isAllDay,
      );

      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.updateEvent(event, widget.event!);
      } else {
        provider.addEvent(event);
      }

      Navigator.of(context).pop();
    }
  }
}
