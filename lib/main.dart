import 'package:flutter/material.dart';
import 'pages/home.dart';

// Tela de Calendário
// Tela de Gerenciamento de Disciplinas

void main() {
  return runApp(const CalendarApp());
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
  }
}

