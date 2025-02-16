import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_quest/pages/calendar_page.dart';
import 'package:study_quest/pages/event_editing_page.dart';
import 'package:study_quest/providers/event_provider.dart';
import 'package:study_quest/widgets/app_drawer.dart';
import 'package:study_quest/widgets/calendar_widget.dart';
import 'providers/appointment_provider.dart';
import 'providers/subject_provider.dart';
import 'repositories/appointment_repository.dart';
import 'repositories/subject_repository.dart';

import 'views/calendar/calendar.dart';
import 'views/subjects/subjects.dart';
import 'providers/progress_provider.dart';
import 'views/progress/progress.dart';
import 'pages/authentication_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectRepository = SubjectRepository();
    final appointmentRepository = AppointmentRepository();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(
            create: (context) => SubjectProvider(subjectRepository)),
        ChangeNotifierProvider(
            create: (context) => AppointmentProvider(appointmentRepository)),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: MaterialApp(
        title: 'Study Quest',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: CalendarPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   String selectedPage = 'Página Inicial';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Study Quest'),
//       ),
//       drawer: AppDrawer(
//         selectedPage: selectedPage,
//         onItemSelected: (String page) {
//           setState(() => selectedPage = page);
//         },
//       ),
//       body: CalendarWidget(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         onPressed: () => Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => EventEditingPage())),
//         child: Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
