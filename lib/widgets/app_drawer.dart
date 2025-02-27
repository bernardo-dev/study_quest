import 'package:flutter/material.dart';
import 'package:study_quest/pages/calendar_page.dart';
import 'package:study_quest/views/progress/progress.dart';
import 'package:study_quest/views/subjects/subjects.dart';

class AppDrawer extends StatelessWidget {
  final String selectedPage; // Passando a página selecionada
  final ValueChanged<String> onItemSelected;

  const AppDrawer(
      {super.key, required this.selectedPage, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Study Quest',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Página Inicial'),
            tileColor: selectedPage == 'Página Inicial'
                ? Colors.blue.withOpacity(0.2)
                : null, // Página atual com cor diferenciada
            onTap: () {
              // If the selected page is the current page, close the drawer
              if (selectedPage == "Página Inicial") {
                Navigator.pop(context);
              } else {
                onItemSelected('Página Inicial');
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CalendarPage(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Disciplinas'),
            tileColor: selectedPage == 'Disciplinas'
                ? Colors.blue
                : null, // Página atual com cor diferenciada
            onTap: () {
              if (selectedPage == "Disciplinas") {
                Navigator.pop(context);
              } else {
                onItemSelected('Disciplinas');
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SubjectsPage(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.line_axis),
            title: const Text('Progresso'),
            tileColor: selectedPage == 'Progresso'
                ? Colors.blue
                : null, // Página atual com cor diferenciada
            onTap: () {
              if (selectedPage == "Progresso") {
                Navigator.pop(context);
              } else {
                onItemSelected('Progresso');
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ProgressScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
