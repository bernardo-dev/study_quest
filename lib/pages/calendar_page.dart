import 'package:flutter/material.dart';
import 'package:study_quest/pages/event_editing_page.dart';
import 'package:study_quest/widgets/app_drawer.dart';
import 'package:study_quest/widgets/calendar_widget.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    String selectedPage = 'Página Inicial';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
      ),
      drawer: AppDrawer(
        selectedPage: selectedPage,
        onItemSelected: (String page) {
          setState(() => selectedPage = page);
        },
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
        child: Icon(Icons.add),
      ),
    );
  }
}
