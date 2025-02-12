import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/appointment_editor_state.dart';
import 'providers/appointment_provider.dart';
import 'providers/subject_provider.dart';
import 'repositories/appointment_repository.dart';
import 'repositories/subject_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'views/calendar/calendar.dart';
import 'views/subjects/subjects.dart';
import 'providers/progress_provider.dart';
import 'views/progress/progress.dart';
// Tela de Calendário
// Tela de Gerenciamento de Disciplinas

// void main() {
//   return runApp(ChangeNotifierProvider(
//     create: (context) => AppointmentState(),
//     child: const CalendarApp(),
//   ));
// }
void main() {
  final subjectRepository = SubjectRepository();
  final appointmentRepository = AppointmentRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppointmentState()),
        ChangeNotifierProvider(create: (context) => SubjectProvider(subjectRepository)),
        ChangeNotifierProvider(create: (context) => AppointmentProvider(appointmentRepository)),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: const CalendarApp(),
    ),
  );
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      locale: Locale('pt', 'BR'),
      title: 'Study Quest',
      home: CalendarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
