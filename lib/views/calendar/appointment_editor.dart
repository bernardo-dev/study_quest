import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_quest/providers/appointment_editor_state.dart';

class AppointmentEditor extends StatefulWidget {
  const AppointmentEditor({super.key});

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  @override
  Widget build(BuildContext context) {
    final appointmentState = Provider.of<AppointmentState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(E),
      ),
    );
  }

  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            leading: const Text(''),
            title: TextField(
              controller: TextEditingController(text: _subject),
            ),
          ),
        ],
      ),
    );
  }
}
