import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_quest/providers/appointment_editor_state.dart';
import 'package:intl/intl.dart';

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({super.key});

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  Widget _getAppointmentEditor(BuildContext context) {
    final appointmentState = Provider.of<AppointmentState>(context);
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            leading: const Text(''),
            title: TextField(
              controller: TextEditingController(text: appointmentState.subject),
              onChanged: (String value) {
                appointmentState.setSubject(value);
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Add title',
              ),
            ),
          ),
          const Divider(
            height: 1.0,
            thickness: 1,
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Icon(Icons.access_time),
            title: Row(
              children: [
                const Expanded(child: Text('All-day')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                        value: appointmentState.isAllDay,
                        onChanged: (bool value) {
                          appointmentState.setAllDay(value);
                        }),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Text(''),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    child: Text(
                      DateFormat('EEE, MMM dd yyyy')
                          .format(appointmentState.startDate),
                      textAlign: TextAlign.left,
                    ),
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: appointmentState.startDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (date != null && date != appointmentState.startDate) {
                        setState(
                          () {
                            final Duration difference =
                                appointmentState.endDate.difference(
                              appointmentState.startDate,
                            );
                            appointmentState.setStartDate(
                              DateTime(
                                date.year,
                                date.month,
                                date.day,
                                appointmentState.startTime.hour,
                                appointmentState.startTime.minute,
                                0,
                              ),
                            );
                            appointmentState.setEndDate(
                              appointmentState.startDate.add(difference),
                            );
                            appointmentState.setEndTime(
                              TimeOfDay(
                                  hour: appointmentState.endDate.hour,
                                  minute: appointmentState.endDate.minute),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: appointmentState.isAllDay
                      ? const Text('')
                      : GestureDetector(
                          child: Text(
                            DateFormat('hh:mm a')
                                .format(appointmentState.startDate),
                            textAlign: TextAlign.right,
                          ),
                          onTap: () async {
                            final TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: appointmentState.startTime.hour,
                                    minute: appointmentState.startTime.minute));
                            if (time != null &&
                                time != appointmentState.startTime) {
                              setState(() {
                                appointmentState.setStartTime(time);
                                final Duration difference = appointmentState
                                    .endDate
                                    .difference(appointmentState.startDate);
                                appointmentState.setStartDate(DateTime(
                                    appointmentState.startDate.year,
                                    appointmentState.startDate.month,
                                    appointmentState.startDate.day,
                                    appointmentState.startTime.hour,
                                    appointmentState.startTime.minute,
                                    0));
                                appointmentState.setEndDate(
                                    appointmentState.startDate.add(difference));
                                appointmentState.setEndTime(TimeOfDay(
                                    hour: appointmentState.endDate.hour,
                                    minute: appointmentState.endDate.minute));
                              });
                            }
                          }),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Text(''),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    child: Text(
                      DateFormat('EEE, MMM dd yyyy')
                          .format(appointmentState.endDate),
                      textAlign: TextAlign.left,
                    ),
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: appointmentState.endDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (date != null && date != appointmentState.endDate) {
                        setState(() {
                          final Duration difference = appointmentState.endDate
                              .difference(appointmentState.startDate);
                          appointmentState.setEndDate(
                            DateTime(
                              date.year,
                              date.month,
                              date.day,
                              appointmentState.endTime.hour,
                              appointmentState.endTime.minute,
                              0,
                            ),
                          );
                          if (appointmentState.endDate
                              .isBefore(appointmentState.startDate)) {
                            appointmentState.setStartDate(
                                appointmentState.endDate.subtract(difference));
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(getTitle(Provider.of<AppointmentState>(context))),
      ),
    ));
  }

  String getTitle(AppointmentState appointmentState) {
    return appointmentState.subject.isEmpty
        ? 'New Appointment'
        : 'Edit Appointment';
  }
}

// class AppointmentEditorState extends State<AppointmentEditor> {
//   @override
//   Widget build(BuildContext context) {
//     final appointmentState = Provider.of<AppointmentState>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Appointment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: TextEditingController(text: appointmentState.subject),
//               onChanged: (value) {
//                 appointmentState.setSubject(value);
//               },
//               decoration: InputDecoration(labelText: 'Subject'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
